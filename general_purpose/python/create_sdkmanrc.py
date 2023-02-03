#!/usr/bin/env python3
####################################################################################################
#Script Name	: create_sdkmanrc.py
#Description	: Creates a .sdkmanrc file. If the file already exists then it shows an error.
#                                                                                 
#Args           : 
#Author       	: Francisco Güemes                                                
#Email         	: francisco@franciscoguemes.com                                           
#See also	    : 
#
####################################################################################################

# TODOs:
# 2 - Place the auxiliar scripts on its own directory under bash scripts directory
# 3 - See how to get where this script is located and based on that the path of the auxiliar scripts
# 4 - Comment the deletion of the .sdkmanrc file
# 5 - Cleanup code
# 6 - Document code
# 7 - Create the script for the update of the .sdkmanrc


# Some common Python imports add/delete conveniently
import sys  
import re   
import os
import subprocess
import enum
import traceback

# Constants definitions
FILE_NAME=".sdkmanrc"
SDKMANRC_HEADER="""
# Enable auto-env through the sdkman_auto_env config
# Add key=value pairs of SDKs to use below
# ======================================================
""".strip()
HEADER_TEMPLATE="""
# ------------------------------------------------------
# {0} 
# ------------------------------------------------------
""".strip()


def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


def delete_sdkmanrc():
    if os.path.exists(FILE_NAME):
        os.remove(FILE_NAME)
        print(f"The file {FILE_NAME} was deleted.")


def check_sdkmanrc_exists():
    if os.path.exists(FILE_NAME):
        return True
    return False


class Sdk():
    def __init__(self, title, name, help_script):
        self.title = title
        self.name = name
        self.help_script = help_script

    def get_pair_left_side(self):
        return "#" + self.name + "="


def list(sdk: Sdk):
    result = ""
    try:
        #print(f"The help script is {sdk.help_script}")
        # https://stackoverflow.com/questions/4760215/running-shell-command-and-capturing-the-output
        # https://stackoverflow.com/questions/13745648/running-bash-script-from-within-python
        result = subprocess.run([sdk.help_script], capture_output=True, text=True)
        result = result.stdout
    except FileNotFoundError as e:
        eprint(f"The help script {sdk.help_script} can not be found!")
        # https://stackoverflow.com/questions/1483429/how-do-i-print-an-exception-in-python
        #traceback.print_exc()
    return result


def get_pairs_for(sdk: Sdk):
    if sdk.name == "java":
        return get_pairs_from_table(sdk)
    else:        
        return get_pairs_from_list(sdk)


def get_pairs_from_table(sdk: Sdk):
    versions_as_multiline_string = list(sdk)
    lines=versions_as_multiline_string.splitlines()
    selected_lines=[]
    for line in lines:
        if "|" in line:
            #https://www.geeksforgeeks.org/python-append-string-to-list/
            selected_lines+=[line]
    selected_lines= selected_lines[1:]

    java_pairs=[]
    for line in selected_lines:
        columns=line.split("|")
        if columns[4].strip():
            java_pairs+=[sdk.get_pair_left_side() + columns[5].strip()]
    return java_pairs


def get_pairs_from_list(sdk: Sdk):
    versions_as_multiline_string = list(sdk)
    lines=versions_as_multiline_string.splitlines()
    selected_lines=[]
    for line in lines:
        if "." in line:
            selected_lines+=[line]
    
    maven_pairs=[]
    for line in selected_lines:
        columns=line.split("    ")
        for column in columns:
            if "*" in column:
                maven_pairs+=[sdk.get_pair_left_side() + column.replace(">","").replace("*","").strip()]
    
    return maven_pairs


def append_pairs(file, pairs: list, title: str):
    if not pairs:
        return

    file.write("\n")
    file.write("\n")
    file.write(HEADER_TEMPLATE.format(title))
    file.write("\n")
    for pair in pairs:
        file.write(pair)
        file.write("\n")


if __name__ == "__main__":
    delete_sdkmanrc()

    #pwd
    #print("File location using os.getcwd():", os.getcwd())

    #Directory where this file is placed. It may not be the same as pwd!!!
    #current_directory = os.path.dirname(os.path.abspath(__file__))
    #print(f"The current directory of the script is: {current_directory}")

    if check_sdkmanrc_exists():
        print(f"The file {FILE_NAME} already exists.")
        exit(1) # Abnormal execution so return some error code to the OS

    java = Sdk("Java", "java", "./general_purpose/python/list_java.sh")
    maven = Sdk("Maven", "maven", "./general_purpose/python/list_maven.sh")
    gradle = Sdk("Gradle", "gradle", "./general_purpose/python/list_gradle.sh")
    groovy = Sdk("Groovy", "groovy", "./general_purpose/python/list_groovy.sh")

    java_pairs=get_pairs_for(java)
    maven_pairs=get_pairs_for(maven)
    gradle_pairs=get_pairs_for(gradle)
    groovy_pairs=get_pairs_for(groovy)

    print(f"The file {FILE_NAME} would be created here!")
    with open(FILE_NAME, "w") as file:
        file.write(SDKMANRC_HEADER)

        append_pairs(file, java_pairs, java.title)      
        append_pairs(file, maven_pairs, maven.title)
        append_pairs(file, gradle_pairs, gradle.title)
        append_pairs(file, groovy_pairs, groovy.title)
