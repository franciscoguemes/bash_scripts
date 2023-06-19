#!/usr/bin/env bash
####################################################################################################
#Args           : 
#                                                                                                 
#Usage          :   
#Output stdout  :   
#Output stderr  :   
#Return code    :   
#Description	: Setup the test environment for the replace_vv.sh script
#                                                                                                                                                           
#Author       	: Francisco Güemes                                                
#Email         	: francisco@franciscoguemes.com                                           
#See also	    : 
#                   https://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html
#  
####################################################################################################


readonly SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
readonly PROJECT_DIR=$(dirname "$SCRIPT_DIR")
readonly TEST_DIR=${PROJECT_DIR}/test
readonly TARGET_DIR=${PROJECT_DIR}/target
readonly RESOURCES_DIR=${TEST_DIR}/resources


function create_target_dir {
  if [[ -d $TARGET_DIR ]]; then
    rm -Rf $TARGET_DIR
  fi
  mkdir $TARGET_DIR
}


function copy_resources {
  my_array=( $(ls $RESOURCES_DIR))
  #echo "arguments length ${#my_array[@]}"
  #echo ${my_array[@]}
  #echo $PWD
  for element in "${my_array[@]}"; do
      path="${RESOURCES_DIR}/${element}"
      #echo "$path"
      cp -rf "$path" "$TARGET_DIR"
  done
}

function is_test_file {
    local -r PATTERN="\.test$"
    if [[ "$1" =~ $PATTERN ]]; then
        return 0
    fi
    return 1
}

function copy_scripts {
  echo $(basename $0)

  my_array=( $(ls $TEST_DIR))
  #echo "arguments length ${#my_array[@]}"
  #echo ${my_array[@]}

  for element in "${my_array[@]}"; do
      #echo $element
      if is_test_file $element; then
        local script=${element//.test/.sh}
        path=$(find "$PROJECT_DIR" -type f -name "$script")
        #echo "$path"
        cp -rf "$path" "$TARGET_DIR"
      fi
  done

}

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

create_target_dir
copy_resources
copy_scripts

IFS=$SAVEIFS