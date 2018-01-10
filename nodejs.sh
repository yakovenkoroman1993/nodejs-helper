#!/usr/bin/env bash

VERSION="latest"
COMMAND="node -v"
PORTS="3000:3000"

# arguments parser
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
            shift
            shift
        ;;
        -p|--ports)
            PORTS=${2:-${PORTS}}
            shift
            shift
        ;;
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
        ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

# node building
IMAGE_NAME="nodejs-helper-image-${VERSION}"
if ! docker images --format "{{.Repository}}" | grep -q "${IMAGE_NAME}" ; then

    FILE_NAME="Dockerfile.tmp"
    EXPOSE_PORT="${PORTS##*:}"

    cat <<EOF > ${FILE_NAME}
FROM node:${VERSION}
EXPOSE ${EXPOSE_PORT}
CMD ['node', '-v']
EOF
    echo "building $IMAGE_NAME"

    docker build \
        -f ${FILE_NAME} \
        -t ${IMAGE_NAME} .

    rm -rf ${FILE_NAME}
fi

# node running
HASH=$(date +%N | sha256sum | base64 | head -c 12)
CONTAINER_NAME="node-${HASH}"
docker run --rm \
    --name "${CONTAINER_NAME}" \
    -p ${PORTS} \
    --mount type=bind,source=$(pwd),target=//app \
    -w //app \
    ${IMAGE_NAME} \
    bash -c "${COMMAND}"
