#!/bin/zsh

awswp(){
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY_ID
    unset AWS_SESSION_TOKEN

    aws_credentials=$(aws sts assume-role --role-arn "arn:aws:iam::${1}:role/${3}" --role-session-name "assume_role" --profile ${2})

    export AWS_ACCESS_KEY_ID=$(echo $aws_credentials|jq '.Credentials.AccessKeyId'|tr -d '"')
    export AWS_SECRET_ACCESS_KEY=$(echo $aws_credentials|jq '.Credentials.SecretAccessKey'|tr -d '"')
    export AWS_SESSION_TOKEN=$(echo $aws_credentials|jq '.Credentials.SessionToken'|tr -d '"')
}

_awswp ()
{
    local -a commands

    commands=(
        "new:create new virtual environment"
        "activate:activate virtual environment"
        "deactivate:deactivate virtual environment"
        "remove:remove virtual environment"
        "list:show list of virtual environments in local device"
    )

    _arguments -C \
      '1: :->cmds'

    case "$state" in
        (cmds)
            _describe 'commands' commands
        ;;
    esac
}

compdef _awswp awswp
