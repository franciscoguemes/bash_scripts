

# Create global directories (Execute script as sudo)
mkdir -p /usr/lib/jvm

# Create user directories
mkdir -p $HOME/bin
mkdir -p $HOME/.config
mkdir -p $HOME/development/{apache-ant,apache-maven,flyway,eclipse,netbeans}
mkdir -p $HOME/git/{$COMPANY,$USER,other}
mkdir -p $HOME/workspaces/{eclipse,netbeans}