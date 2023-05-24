#!/bin/bash
set -e
shopt -s extglob

#  parse environment variable to gitstats command param name and value
# environment variable extract param name
# 1. Remove prefix GITSTATS_CONFIG_
# 2. Lower case
# 
function function_param_parse() {
    
    gitstats_param_name=$1
    gitstats_param_value=$2

    # remove prefix
    gitstats_param_name=${gitstats_param_name//GITSTATS_CONFIG_/}

    if [[ "${gitstats_param_name:0:1}" = "_" ]]; then
        # not param
        gitstats_param_name=""
        gitstats_param_value=""
    else
        # upper case
        gitstats_param_name="$( echo "$gitstats_param_name" | tr '[:upper:]' '[:lower:]' )"
    fi

    _result_param_name="$gitstats_param_name"
    _result_param_value="$gitstats_param_value"
}


#  generation gitstats command positional parameters 
# 1. Empty value not need append to result
function function_param_generation() {
    
    gitstats_param_name=$1
    gitstats_param_value=$2

    empty_value="false"
    # check value is empty
    [[ "${gitstats_param_value/ /}" = "" ]] && empty_value="true"
    [[ "${gitstats_param_value/:/}" = "" ]] && empty_value="true"

    # start dash (--) with name
    if [[ -z "$gitstats_param_name" ]]; then
        command_param=""
    else
        command_param="-c $gitstats_param_name"
    fi

    # add quotation marks if spaces in param
    if [[ "${gitstats_param_value/ /}" != "$gitstats_param_value" ]]; then
        gitstats_param_value="'$gitstats_param_value'"
    fi

    # append value if need
    if [[ "$empty_value" != "true" ]]; then
        command_param="$command_param=$gitstats_param_value"
    fi

    _result_param="$command_param"
}



#####init_variable

_engine_dir="/gitstats/"
_command_name="gitstats"
_log_redirect=${GITSTATS_PATH_LOG}
GITSTATS_PATH_GIT=${GITSTATS_PATH_GIT}
GITSTATS_PATH_OUTPUT=${GITSTATS_PATH_OUTPUT}

if [[ -z "$GITSTATS_PATH_GIT" ]] && [[ -d "/git-projects/default" ]]; then
    GITSTATS_PATH_GIT="/git-projects/default"
fi
if [[ -z "$GITSTATS_PATH_OUTPUT" ]] && [[ -d "/output-reports/default" ]]; then
    GITSTATS_PATH_OUTPUT="/output-reports/default"
fi

#####begin

# create command
_command_opt=
read -r -a _env_array <<< "$( echo "${!GITSTATS_CONFIG_*}" )"
for _env in "${_env_array[@]}"; do
    function_param_parse "$_env" "${!_env}"
    function_param_generation "$_result_param_name" "$_result_param_value"

    if [[ -z "$_command_opt" ]]; then
        _command_opt="$_result_param"
    else
        _command_opt="$_command_opt $_result_param"
    fi
done
_command="$_engine_dir$_command_name $_command_opt ${GITSTATS_PATH_GIT} ${GITSTATS_PATH_OUTPUT} $@" 

# print command
echo "$_command"

# run command
echo
if [[ -z "$_log_redirect" ]]; then
    $_command
else
    $_command &> "$_log_redirect"
fi
code=$?

# done command
echo
if [[ $code -eq 0 ]]; then
    echo "Ok, run done"
else
    echo "Sorry, some error '$code' make failure"
fi
