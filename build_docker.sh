#!/bin/bash

usage(){
    echo "Usage(): $0 [image_name] [config_file]"
    exit 1
}

setup_environment(){
    if [[ -z ${image_name} ]]
    then
        image_name=${DEFAULT_IMAGE_NAME}
    fi
    
    if [[ -z ${docker_config} ]]
    then
        docker_config=${DEFAULT_DOCKER_CONFIG}
    fi
}

build_image(){
    echo "docker build -f ${docker_config} -t ${image_name} . "
    docker build -f ${docker_config} -t ${image_name} .
}

if [[ ! $# -eq 0 && ! $# -eq 2 ]]
then
    usage
fi

# Reference: https://medium.com/@faizififita1/how-to-deploy-your-streamlit-web-app-to-google-cloud-run-ba776487c5fe
DEFAULT_IMAGE_NAME="streamlit-app"
DEFAULT_DOCKER_CONFIG="Dockerfile"

image_name="$1"
docker_config="$2"

setup_environment
build_image
