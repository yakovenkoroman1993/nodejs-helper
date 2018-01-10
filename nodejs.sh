#!/usr/bin/env bash

VERSION="latest"
COMMAND="node -v"

# args parser
POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -v|--version)
            VERSION=${2:-${VERSION}}
            shift # past argument
            shift # past value
        ;;
        -c|--command)
            COMMAND=${2:-${COMMAND}}
            shift # past argument
            shift # past value
        ;;
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
        ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

# node running
name="node-$(date +%N | sha256sum | base64 | head -c 12)"

docker run --rm \
    --name "${name}" \
    --mount type=bind,source=$(pwd),target=//app \
    -w //app node:${VERSION} \
    bash -c "${COMMAND}"
