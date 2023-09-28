#!/usr/bin/env bash

readonly SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR"/util.sh



function get_script_directory() {
    local SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    echo $SCRIPT_DIR
}

function get_script_parent_directory() {
    local SCRIPT_DIR=$(get_script_directory)
    local PARENT_DIR=$(basename "$SCRIPT_DIR")
    echo $PARENT_DIR
}
