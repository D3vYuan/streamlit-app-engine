#!/bin/bash

usage(){
    echo "Usage(): $0 [image_name]"
    exit 1
}

setup_environment(){
    if [[ -z ${image_name} ]]
    then
        image_name=${DEFAULT_IMAGE_NAME}
    fi

    if [[ -z ${source_port} ]]
    then
        source_port=${DEFAULT_SOURCE_PORT}
    fi
    
    if [[ -z ${destination_port} ]]
    then
        destination_port=${DEFAULT_DESTINATION_PORT}
    fi
}

run_docker(){
    echo "docker run -itd --rm -p ${source_port}:${destination_port} ${image_name}"
    docker run -itd --rm -p ${source_port}:${destination_port} ${image_name}
}

if [[ ! $# -le 3 ]]
then
    usage
fi

DEFAULT_IMAGE_NAME="streamlit-app"
DEFAULT_SOURCE_PORT=8080
DEFAULT_DESTINATION_PORT=8080

image_name="$1"
source_port="$2"
destination_port="$3"

setup_environment
run_docker