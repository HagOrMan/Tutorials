# Why should you care?
Navigating a terminal is an essential skill as a developer. However, you'll find that some common commands get tiring to type out every time. That's a lot of *friction* in your development. **The solution?**
> Bash aliases, a quick way to turn a command like `git checkout` into something as short as `gco`

**So come along as I give a quick rundown on how you can begin building your *bash castle***, as well as provide my own.

# What is bash?
If you aren't using git bash or any other terminal that allows for aliases, I highly recommend it. I'm on windows, so git bash is my best way to get a Unix-like environment.  

For the purposes of this tutorial, you'll need what's known as a `.bashrc` file, which controls what is done on startup of your terminal as well as allows you to create `aliases`, the main focus here. If it doesn't exist, you can just create the file and start adding lines like `alias gs='git status'`! Now the next time you open your terminal, you can run `gs` instead of typing out the full thing.

# My files
While you can absolutely start building your bash castle from scratch, here's what I've done so far to help you get started and maybe give some inspiration.

- [utility functions](./helper-files/bash/util.bashrc). **Highly recommend at least checking out `confirm_action` which is extremely useful for never accidentally doing something catastrophic**
- [useful git aliases](./helper-files/bash/git.bashrc). Almost every git command you'll need in common development

# Setting up your castle
## Put it all together
I'll start with the "once you're done" because maybe you already have some ideas. Once done, take your `.bashrc` file at the root (`~/`) directory and add lines such as
```bash
source ~/git.bashrc
```
for every single extra file you make. I recommend separating them because it's easier to manage and could help you transfer them in the future, rather than having everything in `.bashrc`.

## What should you make?
As you probably know, classic commands like `ls` and `ls -a` or even `ls -al` are already short enough that you don't need to optimize them.
> What's really useful is **longer commands** and commands that **require some scripting to work**.

For example, in my [`util.bashrc`](./helper-files/bash/util.bashrc) file, I have a `confirm_action` function which lets me lock dangerous commands, like discarding all my changes in git, behind a confirmation that asks me if I'm sure I'd like to do that.

> As you try new things and start developing, figure out what commands you run often. If you're taking a while to do something, look it up, as an AI model, and see if there's a faster way to do it. Eventually, you'll find complex commands that would go great behind a bash alias.

For me, a lot of my aliases are also git commands that I run often. **I do anything to reduce friction in my development**, even turning something as short as `git log` into `gl`.
> Keep your commands simple so you can easily add onto them

With `gl`, I can specify more values that would come after `git log` if I wrote it out fully. For example, I can run `gl --oneline` instead of `git log --oneline`.

> For commonly used additions, make a new alias

A good example is `git log --all --graph --oneline --decorate -n 25`, which I alias with the simple `glg`. It produces a nice tree graph similar to what you'd see on VS Code.

# Finishing notes
I'm trying to keep this short and sweet, so hopefully the above gives enough inspiration to get you building without overloading the details. **At the end of the day, you will build what is best for you,** and maybe you'll find a better way to do things (and please let me know if you do).  

Feel free to open an issue on this repo if you want any help or have questions for me!
