#!/usr/bin/env bash
####################################################################################################
#Script Name	: create_directory_structure.sh                                                                                             
#Description	: Creates the directory structure on which the rest of the installation will rely.
#                                                                                 
#Args           :                                                                                           
#Author       	: Francisco Güemes                                                
#Email         	: francisco@franciscoguemes.com                                           
#See also	    : 
# 
####################################################################################################

# Create global directories (Execute script as sudo)
mkdir -p /usr/lib/jvm

# Create user directories
mkdir -p $HOME/{Downloads,Templates,Documents,Videos,Music,Pictures}
mkdir -p $HOME/bin
mkdir -p $HOME/.config
mkdir -p $HOME/development/{apache-ant,apache-maven,flyway,eclipse,netbeans,gradle}
mkdir -p $HOME/git/{$COMPANY,$USER,other}
mkdir -p $HOME/workspaces/{eclipse,netbeans}