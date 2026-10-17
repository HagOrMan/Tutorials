#!/bin/bash

# Used for teamclaude so that it properly runs without ssl errors
teamclaude() {
    if [ "$1" = "run" ]; then
        shift
        NODE_TLS_REJECT_UNAUTHORIZED=0 command teamclaude run "$@"
        return
    fi

    if [ "$1" = "start" ]; then
        shift
        local run_args=("$@")
        local server_script="/tmp/teamclaude_server_$$.sh"
        local run_script="/tmp/teamclaude_run_$$.sh"

        cat > "$server_script" <<'EOF'
command teamclaude server
echo
echo "Server process exited. Press enter to close."
read
EOF

        cat > "$run_script" <<EOF
echo "Waiting for teamclaude server to come up..."
sleep 3
NODE_TLS_REJECT_UNAUTHORIZED=0 command teamclaude run ${run_args[@]}
echo
echo "Run process exited. Press enter to close."
read
EOF

        start bash "$server_script"
        start bash "$run_script"
        return
    fi

    command teamclaude "$@"
}

alias tc='teamclaude run'
alias tcs='teamclaude server'
alias tcss='teamclaude start'

