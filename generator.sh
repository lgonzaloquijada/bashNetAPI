#!/bin/bash

source ./sh_functions/utils.sh
source ./sh_functions/net_solution.sh

if [[ " $@ " =~ " --create " ]]; then
    OPERATION="create"
    set -- ${@/--create/}
elif [[ " $@ " =~ " --delete " ]]; then
    OPERATION="delete"
    set -- ${@/--delete/}
else
    echo "Usage: $0 --create <ProjectName> | --delete <ProjectName>"
    wait_for_user
    exit 1
fi

if [[ $OPERATION == "create" ]]; then
    PROJECT_NAME=$(get_param_value "name" $@)
    create_project $PROJECT_NAME
elif [[ $OPERATION == "delete" ]]; then
    delete_project
else
    echo "Usage: $0 --create <ProjectName> | --delete <ProjectName>"
    wait_for_user
    exit 1
fi

wait_for_user
exit 0