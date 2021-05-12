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

