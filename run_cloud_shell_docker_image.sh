#!/bin/bash

build_script="run_docker.sh"
image_name="cloudshell-streamlit-app"
source_port="8081"

bash ${build_script} ${image_name} ${source_port}