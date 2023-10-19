#!/bin/bash

build_script="build_docker.sh"
docker_file="CloudShellDockerfile"
image_name="cloudshell-streamlit-app"

bash ${build_script} ${image_name} ${docker_file}