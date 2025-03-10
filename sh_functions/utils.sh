#!/bin/bash

wait_for_user() {
    read -p "Press any key to continue..."
}

get_param_value() {
    local param_name="$1"
    shift  # Elimina el primer argumento ($1) para recorrer solo los parámetros restantes

    local param_value=""
    local found=false

    while [[ $# -gt 0 ]]; do
        if [[ "$1" == "--$param_name" ]]; then
            found=true
            shift
            param_value="$1"
            break
        fi
        shift
    done

    if [[ "$found" == false || -z "$param_value" ]]; then
        echo "Error: Parameter '--$param_name' is required. Use --$param_name <value>" >&2
        exit 1
    fi

    echo "$param_value"
}