# Why Should You Care About Bash Aliases?
The reason you're using `git log` and not `git log --all --graph --oneline --decorate`, even though it could **change your life as a developer** (seriously, try it right now), is because it's too long to type and too hard to remember.

But what if you could keep the power of that lengthy command and still type something **simple**? With **bash aliases**, you can turn long, tedious commands into **effortless shortcuts**, like typing `glg` instead of that entire command above.

**So let's get started! I'll show you how to begin building your *bash castle***, a collection of aliases to massively improve your efficiency and reduce characters typed by at least 75\% <sup>[\[1\]](#extra-notes)</sup>.

# What Is Bash / Bash Aliases?
This tutorial uses bash as a short form for "bash terminal", which refers to Unix-like terminals such as Linux terminals, macOS's terminal, and Git Bash on Windows. These terminals support aliases, whereas the default Windows terminals (e.g. Command Prompt and Powershell) do not.

**What is an alias?** An alias is any shortcut for a command. It could be:
- a literal shortcut, such as allowing you to type `g` instead of `git`
- a [bash function](https://tldp.org/LDP/abs/html/functions.html), like one that will [find the largest files in your current directory](./helper-files/bash/terminal.bashrc)
- any combination of commands, including functions!

If your terminal doesn’t support aliases, I recommend using Git Bash. I'm on Windows, so Git Bash is the simplest option <sup>[\[2\]](#extra-notes)</sup>.

For this tutorial, you'll need what's known as a `.bashrc` file. This is a configuration file located in your home directory, `~/`. It controls what is done on initialization of your terminal as well as allows you to create aliases, the main focus here. If it doesn't already exist, you can just create the file and start adding lines like `alias gs='git status'`! Now the next time you open your terminal, you can run `gs` instead of typing out the full thing.

<details>
    <summary>How do I create the bashrc file? <sup><a href="#extra-notes">[3]</a></sup></summary>

    cd ~   # go to your home directory
    vim .bashrc   # open or create the .bashrc file
    # if you don't have vim, nano and vi are other text editors you can use

</details>

# Setting Up Your Castle
## Put It All Together
Let's start by talking about how to make your aliases available in case you already have some ideas. If you want inspiration, you can skip to my aliases [here](#templates-to-help-you-get-started). 

1. I recommend separating your aliases into clearly defined files such as [`git.bashrc`](./helper-files/bash/git.bashrc) (for all git-related aliases) since it is easier to manage and more portable

2. Once you’ve created your alias files, you’ll need to make them available in your terminal. You do this by editing your `.bashrc` file (in your home directory, `~/`). Add a line like this for each alias file you’ve created:
```bash
source ~/git.bashrc
```

3. Now, you need to "activate" the `.bashrc` file. Run the following in your terminal (or alternatively restart your terminal)
```bash
source ~/.bashrc
```

---

**Example Setup:**  
If you've copied all my files to your home (`~/`) directory, your `.bashrc` file should look like this
```bash
source ~/util.bashrc
source ~/git.bashrc
source ~/terminal.bashrc
source ~/venv.bashrc
```

## What Should You Make?
As you probably know, classic commands like `ls` and `ls -a` or even `ls -al` are already short enough that you don't need to optimize them.

> What's really useful is **longer commands** and commands that **require some scripting to work**. Aliases reduce your mental load of remembering these commands and typing them out every time.

You can write functions and then use them in an alias to achieve powerful outcomes. For example, in my [`util.bashrc`](./helper-files/bash/util.bashrc) file, I have a `confirm_action` function that ensures I don't run dangerous commands (e.g., discarding all my changes in git) without confirming that I'm sure.

> As you try new things and develop, figure out what commands you run often. If you're taking a while to do something, look it up, ask an AI model, and see if there's a faster way. These commands make great aliases - and the seconds they save will add up.

For me, a lot of my aliases are also git commands that I run often. **I do anything to reduce friction in my development**, even turning something as short as `git log` into `gl`.
> Keep your commands simple so you can easily add to them

With `gl`, I can specify more values that would come after `git log` if I wrote it out fully. For example, I can run `gl --oneline` instead of `git log --oneline`.

> For commonly used additions, make a new alias

A good example is `git log --all --graph --oneline --decorate`, which I alias with the simple `glg`. It produces a nice tree graph similar to what you might see in GitHub or VS Code.

# Finishing Notes
I'm trying to keep this short and sweet, so hopefully the above gives enough inspiration to get you building without overloading the details. **At the end of the day, you will build what is best for you,** and maybe you'll find a better way to do things (and please let me know if you do).  

Feel free to open an issue on this repo if you want any help or have questions for me!

# Templates To Help You Get Started
While you can absolutely start building your bash castle from scratch, here's what I've done so far to help you get started and maybe give some inspiration.

- [utility functions](./helper-files/bash/util.bashrc). **Highly recommend at least checking out `confirm_action` which is extremely useful for never accidentally doing something catastrophic**
- [useful git aliases](./helper-files/bash/git.bashrc). Almost every git command you'll need in common development. Requires the [utility functions file](./helper-files/bash/util.bashrc)
- [terminal commands](./helper-files/bash/terminal.bashrc). Currently a small list, but might grow as I start doing cooler things in the terminal (common commands in the terminal are already pretty concise though)
- [venv helpers](./helper-files/bash/venv.bashrc). Commands for virtual environments to speed up their creation and use

# Test It Out!
Want to feel like a pro with the new aliases you just made? I'll walk you through how to use them and what to expect! (assuming you're using my aliases and have git installed)

1. In your terminal, navigate to any directory you want to store a new folder in. We're going to clone this repository in the folder that you go to
```bash
# assuming you want to clone it in your home directory
cd ~
gcl https://github.com/HagOrMan/Tutorials.git
```

2. Now navigate into the repo
```bash
cd tutorials
```

3. Let's start by seeing the top files in the repo, sorted by size
```bash
fb
```

4. Now list all files in the root folder of the repo, including hidden files/folders (namely `.git/`)
```bash
lla
```

5. That's a lot on the terminal screen. Let's clear it with an alias
```bash
c
```

6. Now let's check out the version history in a nice graph (type `q` to exit the graph)
```bash
glg
```

7. Let's see what files were modified between some of these commits. I'm taking the commit hashes<sup>[\[4\]](#extra-notes)</sup> seen in the above command to view what changed between the first commit and the second
```bash
changedfiles ad5ff69 9990aa0
```
You should see that `helper-files/bash/venv.bashrc` was modified between those commits.

8. Now let's view the actual content changes in the file. 
```bash
diff-words ad5ff69 9990aa0
```
You should see 3 lines of green text, the green indicating that I added those 3 lines to the file.

# Extra Notes
\[1\] The 75% statistic was taken by looking at all of my current aliases, especially the ones I use most like `git status` &#8594; `gs` (10 characters &#8594; 2 characters), and the fact that using functions in aliases drastically reduces keystrokes. If you write a couple short aliases and are satisfied, you may benefit from a 30-50% keystroke reduction instead.

\[2\] While Git Bash is the most lightweight Unix-like terminal on Windows that I've found, some alternatives exist. Windows has what's called [**Windows Subsystem for Linux (WSL)**](https://learn.microsoft.com/en-us/windows/wsl/install) that allows you to install a Linux distribution with much more functionality than Git Bash (but is conversely less lightweight).

\[3\] To create the file, you can either go through your file explorer or terminal. If you're using the terminal, there are multiple file editors that you can use. I use [vim](https://github.com/vim/vim), and if you're confused on how to edit or save files, I recommend [this tutorial](https://opensource.com/article/19/3/getting-started-vim).

\[4\] Commit hashes are unique identifiers associated with a given change to a repository. In the [6th step above](#test-it-out), the output may include
```
* 9990aa0 feat: add pip list commands to venv.bashrc
```
This shows the commit hash (`9990aa0`), and beside it, the commit message I wrote when making that change. The uniqueness of commit hashes is very useful, such as allowing us to make comparisons between commits, as seen in the [7th and 8th steps above](#test-it-out).
