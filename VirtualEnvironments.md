# Quick Links
- [Why use virtual environments?](#importance-of-virtual-environments)
- [Setup](#setup)
- [Conda Commands](#conda-commands)
- [Python Commands](#python-commands)

# Preface
This file is meant to guide you through the basics of using a virtual environment, why they're used, and also help with setup. It won't be fully comprehensive, there's tons out there including official docs for that, but just everything I use on a regular basis (aka the cherry picked important info that is hopefully everything you'll need too).

If you're looking for help with commands, there's a [section](#main-commands) for that! It's the basics of creating a virtual environment, specifying the python version, installing dependencies, and deleting environments.

I also plan on including commands helpful for `requirements.txt` files, which allow you to save a snapshot of your virtual environment that can be used for anyone to recreate it. This is very important to ensure dependencies are identical when working with other programmers.

# Importance of Virtual Environments
Dependencies can be a pain to work with when you have multiple projects that depend on the same libraries but different versions. Something I was told on co-op is that you shouldn't install dependencies on your "base" environment because you could run into version issues later on. eg. You have a virtual environment that uses LibraryA version 3.1, but your code keeps running the base environment version of 2.5 and you don't know why. (maybe you forgot to activate your venv) 

**Venvs help neatly package your dependencies so they can co-exist and you choose which ones to use and when**. This is especially important in fields such as machine learning which are very library dependant.

# Setup
You're free to download any venv manager of your choice, but my preference is [miniconda](https://docs.anaconda.com/free/miniconda/index.html): https://docs.anaconda.com/free/miniconda/index.html. Follow the instructions on the link, and run `conda --version` in a terminal to ensure it works correctly. Forums like Stack Overflow are your best bet if you run into issues.  

That said, I've recently found some [benefits to using python virtual environments](#why-a-python-venv) instead, so check that out if you're curious and don't want to install something you don't need.

# Conda Commands
## Main Commands
**When creating a new environment**, you can give it a name and optionally specify the python version. Personally, I recommend always specifying the version. Here's me creating an environment called `myenv`, and then creating `myenv` with python version 3.9.
```bash
conda create --name myenv
conda create -n myenv python=3.9
```
I recommend the bottom command because you're be explicit in the python version you want.

**To activate the environment**, just run
```bash
conda activate myenv
```

**To deactivate the environment**, run
```bash
deactivate
```

<details>
    <summary>in mac/linux</summary>

    source deactivate

</details>

**To remove an environment**, run
```bash
conda env remove --name myenv
```

**To see all your created environments**, run
```bash
conda env list
```

**To see the dependencies installed in your currently active environment**, run
```bash
conda list
```

### Work with Dependencies

**To add dependencies**, I use pip (I've heard you should use `conda install` when using conda environments, but I haven't run into any issues yet). Make sure that you don't install any dependencies until you've activated the venv with `conda activate myenv`. Installations will happen in the currently active venv. Pip commands are
```bash
pip install library
pip install library==3.1
```
The first option takes the latest version **available on your python version**, and the second option specifies a version for the dependency. Keep in mind that your python version dictates what versions of a specific library are available. If the version of a library you want isn't available, you'll probably have to upgrade/downgrade your python version.

**To save all of your top level dependencies/libraries** (meaning only the packages that you pip installed) in a `requirements.txt` file, run
```bash
pip list --not-required --format=freeze > requirements.txt
```
**To save all of your dependencies/libraries** in a `requirements.txt` file, where you include the subdependencies (because sometimes one package installs other packages as well), run
```bash
pip list --format=freeze > requirements.txt
```
The reason I give both commands is because I have faced issues making a venv using a `requirements.txt` file created from this command. It had something to do with subdependencies in packages conflicting, so the first command with `--not-required` ensures the only packages are the ones that you directly installed.

**Given a `requirements.txt` file, to install all of the dependencies**, run
```bash
pip install -r requirements.txt
```

The `-r` means requirements install, meaning it looks at the argument `requirements.txt` which comes after it, and installs each dependency in that file line-by-line.

## Create a Jupyter Kernel with your Virtual Environment
As a small addition, here's another command I've needed for machine learning. **This is when working with jupyter notebooks and you want to create a jupyter kernel that contains all of the packages you want**. This is important because jupyter uses _kernels_ to run your code, so to use libraries, you need a kernel that contains those libraries.

First, you install `ipykernel`, then make sure you've used `conda activate myenv` to activate the environment you want turned into a kernel.
```bash
conda install ipykernel
python -m ipykernel install --user --name newenv --display-name "Python (newenv)"
```
What this does is for a given user, creates a kernel with the name `newenv`. The `--display-name` tag sets the name of the kernel to "**Python (newenv)**", which is what you'd see when accessing it in a dropdown to choose the kernel.

This isn't as important when using something like VS Code which can automatically show your conda environments as kernel options, but I've needed it when working in Microsoft Azure's ML Studio.

# Python Virtual Environments
## Why a Python venv?
You might be wondering

> "Why would I use a python virtual environment when conda does it so much better? In conda, I can even separate each environment with the specific python version I want even if I haven't downloaded it yet!"

Well, **the biggest reason I've seen for using python venvs is that unlike conda, python has no licensing issues.** What do I mean by that?  
Well, conda updated their license in 2024 to have restrictions on certain businesses. **So if you're not using conda for personal use, check out their licensing first.**

I've also found python virtual environments great because create the virtual environment in the folder of the project. I'm sure conda has some configuration to create the environment folder in the project as well, but I like that python does not create globally accessible environments like conda. **This helps me because I have lots of unrelated projects where I want them contained to their project folder and inaccessible everywhere else.**
> Make sure you add the virtual environment folder to `.gitignore` if you're using it in a git project

## Python venvs with Different Python Versions
You might have noticed that python venvs, unlike conda, don't let you specify the python version when making them. If you're using python, it is probably part of your path, so you would run `python x.py` to run a python program, rather than specifying the full path to the `python.exe` file.  **To make a venv with a different python version than the one in your path, you need to specify the `python.exe` file in your commands.**  

As a rule of thumb, you can take the commands in the below section, and wherever the first word is `python`, replace it with `C:\path\to\python.exe`. It'll probably look something like `C:\Users\you\AppData\Programs\Python39\python.exe` for python 3.9 as an example.

## Python Commands
**To create a virtual environment** called `.venv`, use
```bash
python -m venv .venv
```
I've seen convention for naming it `venv` as well instead of `.venv`, but I like the `.` since that typically represents hidden files that are ignored by version control in my mind.

**To activate the environment (in git bash on windows)**, run
```bash
. .venv/Scripts/activate
```

<details>
    <summary>In command prompt</summary>

    call .venv/Scripts/activate

</details>
<details>
    <summary>On Linux</summary>

    . .venv/bin/activate

</details>

**To deactivate the environment**, run
```bash
deactivate
```

**Finally, check out [these commands](#work-with-dependencies) to install and work with your dependencies.** For installing, make sure your environment is activated first so the dependencies install in the environment.
