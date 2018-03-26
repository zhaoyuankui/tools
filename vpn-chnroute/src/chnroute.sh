#!/bin/bash

declare routes_file='';
declare default_routes_file='./routes.txt';
declare -i max_routes=0;

function show_help() {
    echo "Usage:";
    echo "    sh chnroute.sh [ROUTE_FILE]";
    echo "    If the ROUTE_FILE is not assigned, the file 'routes.txt'";
    echo "in the current directory will be used.";
}

function check_params() {
    if [ $# -gt 1 ]; then
        show_help;
        exit 1;
    fi
    if [ $# -eq 1 -a -f "$1" ]; then
        routes_file="$1";
        return;
    fi
    if [ $# -eq 1 ]; then
        echo "The file assigned is not normal file or not exist.";
        show_help;
        exit 1;
    fi
    if [ -f "$default_routes_file" ]; then
        routes_file="$default_routes_file";
    fi
    if [ ! "$routes_file" ]; then
        echo "Prepare routes file from server.";
        prepare_routes_file;
    fi
    if [ ! "$routes_file" ]; then
        echo "Routes file not exist.";
        show_help;
        exit 1;
    fi
}

function prepare_routes_file() {
    return 0;
}

function remove_old() {
    sed -i '1d' "$1";
    sed -i '/\s*route.*net_gateway/,$d' "$1";
    return 0;
}

function add_routes() {
    sed -i "1i\max-routes $2" "$1";
    cat "$routes_file" >> "$1";
    return 0;
}

function run() {
    check_params "${@}";
    declare all_confs=(`ls *.ovpn`);
    max_routes=`wc -l "$routes_file" | awk '{print $1}'`;
    max_routes=$((max_routes * 2));
    for conf in ${all_confs[@]}; do
        # Have been processed before.
        if [ "`head -1 $conf | grep 'max-routes'`" ]; then
            remove_old $conf;
        fi
        add_routes "$conf" $max_routes;
    done
}

run "${@}";
