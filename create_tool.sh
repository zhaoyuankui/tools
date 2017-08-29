#!/bin/bash

declare -i bin_install=0;
declare -i conf_install=0;
declare tool_name='';

function show_help() {
    echo "Usage:";
    echo "    sh create_tool.sh [-bc] <TOOL_NAME>";
}

function gen_install_script() {
    echo '#/bin/bash' | tee -a "$1/install.sh" > "$1/uninstall.sh";
    declare type=${1##*/};
    if [ 'src' == "$type" ]; then
        type='bin';
    fi
    echo "# Install script for '$tool_name' $type.\n" >> "$1/install.sh";
    echo "# Uninstall script for '$tool_name' $type.\n" >> "$1/uninstall.sh";
}

function create_tool() {
    echo "Create tool $tool_name. Need bin install: $bin_install; need conf install: $conf_install.";
    mkdir -p {"$tool_name/src","$tool_name/output","$tool_name/conf"};
    cat Makefile.tpl > "$tool_name/Makefile";
    if [ 1 -eq $bin_install ]; then
        gen_install_script "$tool_name/src";
    fi
    if [ 1 -eq $conf_install ]; then
        gen_install_script "$tool_name/conf";
    fi
}

function check_params() {
    if [[ "$1" == -* ]]; then
        if [ "$1" == '-b' ]; then
            bin_install=1;
        elif [ "$1" == '-c' ]; then
            conf_install=1;
        elif [ "$1" == '-bc' -o "$1" == '-cb' ]; then
            bin_install=1;
            conf_install=1;
        elif [ "$1" == '-h' ]; then
            show_help;
            exit 0;
        else
            echo '[ERROR] Parameter not right.';
            show_help;
            exit 1;
        fi
        shift;
    fi

    if [ $# -ne 1 ]; then
        echo '[ERROR] No tool name given.';
        show_help;
        exit 1;
    fi
    if [ -e "$1" ]; then
        echo "Tool '$1' already exists.";
        exit 1;
    fi
    tool_name="$1";
}

function run() {
    check_params ${@};
    create_tool;
}

run ${@};
