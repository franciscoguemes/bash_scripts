# bash_scripts

This project contains a collecion of multipurpose bash scripts that I use under Ubuntu Linux.

## Structure of the project

The project is structured in the following directories:

```bash
.
├── customize
│   ├── git
│   ├── linux
│   ├── linux_setup.sh
│   ├── templates
│   ├── ubuntu
│   └── ubuntu_setup.sh
├── general_purpose
│   ├── bash
│   └── python
└── install.sh
```

The _general_purpose_ directory contains scripts that will be often called from the command line and therefore are subtle to be include in the `$PATH` variable of your OS.

The scripts under the _customize_ directory are the ones designated to transform your OS in order to get a similar setup than the one I have in my machine. In other words you can get the same Ubuntu customization (UI, extra menu options, etc..) and the same Linux customization (Install packages, extender terminal functions, environment variables, etc...). Inside the _customize_ directory there are the scripts _linux_setup.sh_ and _ubuntu_setup.sh_ to install the respective customizations.



## Requirements

The scripts are coded in:
 - [Bash](https://www.gnu.org/software/bash/) 4.X or above
 - [Python](https://www.python.org/) 3.X or above


You can check which version of bash you have installed in your system by using any of the two commands below:
```bash
# General way of checking your bash version
bash --version
# Get only bash version number
echo "${BASH_VERSION}"
```

In the case of Python you can check your installed versions by typing:
```bash
# For python 2.X versions
python --version
# For python 3.X versions
python3 --version
```

## Colaborating with the project

Fell free to colaborate with the project creating a fork of this project and customizing it for your favourite Linux distribution or sugesting new ideas, scripts and customizations for the generic Linux part or the Ubuntu customization.

As any other project there are some rules and standards that I followed when created the project.

### New scripts
In order to create new scripts, please use the templates located in the folder `templates` of this project and follow the conventions shown in the template such as the documentation header, the documentation in the functions, the naming conventions for global variables, etc...

### TODOs
The pending tasks will be marked with the _TODO:_ tag and then what is missing. 
```bash
TODO: Here a clear description of what is missing
```

### Interpolation
All values that will be interpolated during the installation process must be in the format 
```bash
<<<KEY_TO_INTERPOLATE>>>
```

### Interpolation directory
The interpolation directory will be `.target` inside the current directory.

During the installation process the files are copied to the directory `./.target` and then interpolated. So if you run the installation with the DryRun; inside this directory you can see the source scripts that would be installed in your computer.
