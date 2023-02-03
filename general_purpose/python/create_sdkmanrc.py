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
# 1 - Finish the listing for:
#   1.1 - maven
#   1.2 - gradle
#   1.3 - groovy
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


def delete_sdkmanrc():
    if os.path.exists(FILE_NAME):
        os.remove(FILE_NAME)
        print(f"The file {FILE_NAME} was deleted.")


def check_sdkmanrc_exists():
    if os.path.exists(FILE_NAME):
        return True
    return False


def list_java():
    # https://stackoverflow.com/questions/4760215/running-shell-command-and-capturing-the-output
    # https://stackoverflow.com/questions/13745648/running-bash-script-from-within-python
    result = subprocess.run(["./general_purpose/python/list_java.sh"], capture_output=True, text=True)
    return result.stdout

def list_maven():
    # https://stackoverflow.com/questions/4760215/running-shell-command-and-capturing-the-output
    # https://stackoverflow.com/questions/13745648/running-bash-script-from-within-python
    result = subprocess.run(["./general_purpose/python/list_maven.sh"], capture_output=True, text=True)
    return result.stdout

def list_gradle():
    # https://stackoverflow.com/questions/4760215/running-shell-command-and-capturing-the-output
    # https://stackoverflow.com/questions/13745648/running-bash-script-from-within-python
    result = subprocess.run(["./general_purpose/python/list_gradle.sh"], capture_output=True, text=True)
    return result.stdout

def list_groovy():
    # https://stackoverflow.com/questions/4760215/running-shell-command-and-capturing-the-output
    # https://stackoverflow.com/questions/13745648/running-bash-script-from-within-python
    result = subprocess.run(["./general_purpose/python/list_groovy.sh"], capture_output=True, text=True)
    return result.stdout


def get_pairs_from_table(java_versions_as_multiline_string, left_pair):
    lines=java_versions_as_multiline_string.splitlines()

    selected_lines=[]
    for line in lines:
        # print(line)
        if "|" in line:
            #https://www.geeksforgeeks.org/python-append-string-to-list/
            selected_lines+=[line]
    selected_lines= selected_lines[1:]

    java_pairs=[]
    for line in selected_lines:
        columns=line.split("|")
        # print(columns)
        # print(columns[4])
        if columns[4].strip():
            java_pairs+=[left_pair + columns[5].strip()]
    return java_pairs


def get_paris_from_list(maven_versions_as_multiline_string, left_pair):
    # print(maven_versions_as_multiline_string)
    lines=maven_versions_as_multiline_string.splitlines()
    # print(lines)
    selected_lines=[]
    for line in lines:
        if "." in line:
            selected_lines+=[line]
    #print(selected_lines)     
    maven_pairs=[]
    for line in selected_lines:
        columns=line.split("    ")
        for column in columns:
            if "*" in column:
                maven_pairs+=[left_pair + column.replace(">","").replace("*","").strip()]
    # print(maven_pairs)
    return maven_pairs


def append_pairs(file, pairs, title):
    file.write("\n")
    file.write("\n")
    file.write(HEADER_TEMPLATE.format(title))
    file.write("\n")
    for pair in pairs:
        file.write(pair)
        file.write("\n")


if __name__ == "__main__":
    # Your script starts here...
    #some_error_happened=False

    delete_sdkmanrc()

    #pwd
    #print("File location using os.getcwd():", os.getcwd())

    #Directory where this file is placed. It may not be the same as pwd!!!
    #current_directory = os.path.dirname(os.path.abspath(__file__))
    #print(f"The current directory of the script is: {current_directory}")

    if check_sdkmanrc_exists():
        print(f"The file {FILE_NAME} already exists.")
        exit(1) # Abnormal execution so return some error code to the OS

    java_pairs = get_pairs_from_table(list_java(), "#java=")
    maven_pairs = get_paris_from_list(list_maven(), "#maven=")
    gradle_pairs = get_paris_from_list(list_gradle(), "#gradle=")
    groovy_pairs = get_paris_from_list(list_groovy(), "#groovy=")


    print(f"The file {FILE_NAME} would be created here!")

    with open(FILE_NAME, "w") as file:
        file.write(SDKMANRC_HEADER)

        append_pairs(file, java_pairs, "Java")      
        append_pairs(file, maven_pairs, "Maven")
        append_pairs(file, gradle_pairs, "Gradle")
        append_pairs(file, groovy_pairs, "Groovy")


        # for line in selected_lines:
        #     file.write(line)
        #     file.write("\n")

