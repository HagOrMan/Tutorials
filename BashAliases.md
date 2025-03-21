# Why should you care?
Navigating a terminal is an essential skill as a developer. However, you'll find that some common commands get tiring to type out every time. That's a lot of *friction* in your development. **The solution?**

> Bash aliases, a quick way to turn a command like `git checkout` into something short like `gco`

**So come along as I give a quick rundown on how you can begin building your *bash castle***, a collection of aliases to massively improve your efficiency and reduce characters typed by at least 75\%.

# What is bash?
I use bash as a short form for "bash terminal", which in this tutorial means a Unix-like terminal. If you're familiar with Command Prompt or Powershell on Windows, those are two other terminal examples. However, they have no Unix-like functionality and do not apply to this tutorial.

If your terminal doesn’t support aliases, I highly recommend using Git Bash or another Unix-like terminal. I'm on Windows, so Git Bash is the simplest way to get a Unix-like environment <sup>[\[1\]](#extra-resources)</sup>. 

For this tutorial, you'll need what's known as a `.bashrc` file. This is found in your root directory, `~/`. It controls what is done on initialization of your terminal as well as allows you to create `aliases`, the main focus here. If it doesn't already exist, you can just create the file and start adding lines like `alias gs='git status'`! Now the next time you open your terminal, you can run `gs` instead of typing out the full thing.

<details>
    <summary>How do I create the bashrc file?</summary>

    cd ~
    vim .bashrc
    # if you don't have vim, nano and vi are other text editors you can use

</details>

# My files
While you can absolutely start building your bash castle from scratch, here's what I've done so far to help you get started and maybe give some inspiration. If you've never heard of aliases before, it might be helpful to read the rest of the tutorial before checking these out.

- [utility functions](./helper-files/bash/util.bashrc). **Highly recommend at least checking out `confirm_action` which is extremely useful for never accidentally doing something catastrophic**
- [useful git aliases](./helper-files/bash/git.bashrc). Almost every git command you'll need in common development
- [terminal commands](./helper-files/bash/terminal.bashrc). Currently a small list, but might grow as I start doing cooler things in the terminal. (most commands in the terminal are already pretty concise though)
- [venv helpers](./helper-files/bash/venv.bashrc). Commands for virtual environments to speed up their creation and use

# Setting up your castle
## Put it all together
Let's start by talking about how to make your aliases available in case you already have some ideas. I recommend separating your aliases into clearly defined files such as `git.bashrc` (for all git-related aliases) since it's easier to manage. Once you have an alias file ready, take your `.bashrc` file at the root (`~/`) directory, and for each alias file add lines to `~/.bashrc` such as
```bash
# .bashrc file
source ~/git.bashrc
```
Now, run the following in your terminal (or just restart your terminal) to "activate" the file
```bash
source ~/.bashrc
```

## What should you make?
As you probably know, classic commands like `ls` and `ls -a` or even `ls -al` are already short enough that you don't need to optimize them.
> What's really useful is **longer commands** and commands that **require some scripting to work**.

You can write functions and then use them in an alias to achieve powerful outcomes. For example, in my [`util.bashrc`](./helper-files/bash/util.bashrc) file, I have a `confirm_action` function that lets me lock dangerous commands (e.g. discarding all my changes in git) behind a confirmation that asks me if I'm sure I'd like to do that.

> As you try new things and start developing, figure out what commands you run often. If you're taking a while to do something, look it up, ask an AI model, and see if there's a faster way to do it. Eventually, you'll find complex commands that would go great behind a bash alias.

For me, a lot of my aliases are also git commands that I run often. **I do anything to reduce friction in my development**, even turning something as short as `git log` into `gl`.
> Keep your commands simple so you can easily add to them

With `gl`, I can specify more values that would come after `git log` if I wrote it out fully. For example, I can run `gl --oneline` instead of `git log --oneline`.

> For commonly used additions, make a new alias

A good example is `git log --all --graph --oneline --decorate -n 25`, which I alias with the simple `glg`. It produces a nice tree graph similar to what you'd see on VS Code.

# Finishing notes
I'm trying to keep this short and sweet, so hopefully the above gives enough inspiration to get you building without overloading the details. **At the end of the day, you will build what is best for you,** and maybe you'll find a better way to do things (and please let me know if you do).  

Feel free to open an issue on this repo if you want any help or have questions for me!

# Extra Resources
\[1\] While Git Bash is the most lightweight Unix-like terminal on Windows that I've found, some alternatives exist. Windows has what's called [**Windows Subsystem for Linux (WSL)**](https://learn.microsoft.com/en-us/windows/wsl/install) that allows you to install a Linux distribution with much more functionality than Git Bash (but is conversely less lightweight).
