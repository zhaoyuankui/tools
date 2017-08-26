#!/bin/bash

function show_help() {
    echo "Usage:";
    echo "    sh create_tool.sh <TOOL_NAME>";
}

function create_tool() {
    mkdir -p {"$1/src","$1/output","$1/conf"};
    cat Makefile.tpl > "$1/Makefile";
}

if [ $# -ne 1 ]; then
    show_help;
    exit 1;
fi

if [ -e "$1" ]; then
    echo "Tool '$1' already exists.";
    exit 1;
fi

create_tool "$1";
