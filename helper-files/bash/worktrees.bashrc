#!/bin/bash

# ---------------------------------------------------------------------------
# git worktree helpers
# ---------------------------------------------------------------------------

# Where all worktrees live. Override before sourcing if you want another spot.
: "${WT_ROOT:=$HOME/GitHub/worktrees}"

# wt <feature-name> [--no-install] [--no-code]
#
# Creates $WT_ROOT/<repo-name>-<feature-name> on a new branch, copies gitignored
# files listed in .worktreeinclude, installs deps, opens VS Code, and cds you in.
wt() {
    local slug branch base common_dir main_repo repo dir candidate src rel
    local do_install=1 do_code=1

    while [ $# -gt 0 ]; do
        case "$1" in
            --no-install) do_install=0; shift ;;
            --no-code)    do_code=0;    shift ;;
            -h|--help)
                echo "usage: wt <feature-name> [--no-install] [--no-code]"
                return 0 ;;
            -*) echo "wt: unknown option: $1" >&2; return 1 ;;
            *)  slug="$1"; shift ;;
        esac
    done

    if [ -z "$slug" ]; then
        echo "usage: wt <feature-name> [--no-install] [--no-code]" >&2
        return 1
    fi

    # Normalise the name so it is safe as a branch, a directory, and a
    # Vercel preview subdomain: lowercase, non-alphanumerics collapsed to
    # dashes, no leading or trailing dash.
    slug=$(printf '%s' "$slug" \
        | tr '[:upper:]' '[:lower:]' \
        | sed -e 's/[^a-z0-9]\{1,\}/-/g' -e 's/^-*//' -e 's/-*$//')

    if [ -z "$slug" ]; then
        echo "wt: feature name reduced to nothing after cleanup" >&2
        return 1
    fi

    # Resolve the MAIN checkout, not wherever we happen to be standing. This is
    # what makes `wt` work when called from inside another worktree: every
    # worktree shares one common git dir, and its parent is the main checkout.
    common_dir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    if [ -z "$common_dir" ]; then
        echo "wt: not inside a git repository" >&2
        return 1
    fi
    main_repo=$(dirname "$common_dir")
    repo=$(basename "$main_repo")
    dir="$WT_ROOT/$repo-$slug"
    branch="$slug"

    if [ -e "$dir" ]; then
        echo "wt: $dir already exists" >&2
        return 1
    fi

    # Branch from the remote's default branch so features start clean rather
    # than inheriting whatever is checked out right now.
    git -C "$main_repo" fetch --quiet origin 2>/dev/null
    base=$(git -C "$main_repo" symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)
    if [ -z "$base" ]; then
        for candidate in origin/main origin/master; do
            if git -C "$main_repo" rev-parse --verify --quiet "$candidate" >/dev/null; then
                base="$candidate"
                break
            fi
        done
    fi
    : "${base:=HEAD}"

    mkdir -p "$WT_ROOT" || return 1

    if git -C "$main_repo" show-ref --verify --quiet "refs/heads/$branch"; then
        # Branch already exists locally: check it out rather than recreating it.
        git -C "$main_repo" worktree add "$dir" "$branch" || return 1
    else
        # --no-track: without it the new branch tracks origin/main, and a later
        # `git pull` in the worktree would drag main into your feature branch.
        git -C "$main_repo" worktree add --no-track -b "$branch" "$dir" "$base" || return 1
    fi

    # Carry over gitignored files (.env.local and friends). Reuses the same
    # .worktreeinclude file Claude Code reads, so there is only one list to
    # maintain. This does simple glob matching, not full gitignore syntax.
    if [ -f "$main_repo/.worktreeinclude" ]; then
        while IFS= read -r pattern || [ -n "$pattern" ]; do
            case "$pattern" in ''|\#*) continue ;; esac
            # Deliberately unquoted so the shell expands the glob.
            for src in "$main_repo"/$pattern; do
                [ -e "$src" ] || continue
                rel="${src#"$main_repo"/}"
                mkdir -p "$dir/$(dirname "$rel")"
                cp -R "$src" "$dir/$rel"
                echo "wt: copied $rel"
            done
        done < "$main_repo/.worktreeinclude"
    fi

    if [ "$do_install" -eq 1 ] && [ -f "$dir/package.json" ]; then
        echo "wt: installing dependencies..."
        ( cd "$dir" && pnpm install --prefer-offline ) || {
            echo "wt: pnpm install failed; worktree is still usable" >&2
        }
    fi

    if [ "$do_code" -eq 1 ] && command -v code >/dev/null 2>&1; then
        code -n "$dir"
    fi

    cd "$dir" || return 1

    printf '\n  worktree  %s\n  branch    %s (from %s)\n\n' "$dir" "$branch" "$base"
    printf '  push with:  git push -u origin %s\n\n' "$branch"
}

# wtrm [path]
#
# Removes the worktree you are standing in (or the one at [path]) and deletes
# its branch. Refuses to touch the main checkout.
wtrm() {
    local target common_dir main_repo branch
    target="${1:-$PWD}"

    common_dir=$(git -C "$target" rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    if [ -z "$common_dir" ]; then
        echo "wtrm: not inside a git repository" >&2
        return 1
    fi
    main_repo=$(dirname "$common_dir")
    target=$(git -C "$target" rev-parse --show-toplevel)

    if [ "$target" = "$main_repo" ]; then
        echo "wtrm: refusing to remove the main checkout" >&2
        return 1
    fi

    branch=$(git -C "$target" rev-parse --abbrev-ref HEAD)

    cd "$main_repo" || return 1
    if ! git worktree remove "$target"; then
        echo "wtrm: worktree has uncommitted work; rerun with:" >&2
        echo "      git worktree remove --force '$target'" >&2
        return 1
    fi
    git branch -d "$branch" 2>/dev/null || \
        echo "wtrm: branch $branch kept (not fully merged)"
    echo "wtrm: removed $target"
}

# wtls — list worktrees for the current repo.
wtls() {
    git worktree list
}
