#!/bin/bash

if [[ ! $# -eq 1 && ! $# -eq 2 ]]
then
    echo "Usage(): $0 [streamlit_file] [server_port]"
    exit 1
fi

DEFAULT_STREAMLIT_PORT="8501"
python_file="$1"
server_port="$2"

if [[ -z "${server_port}" ]]
then
    server_port=${DEFAULT_STREAMLIT_PORT}
fi

python3 -m streamlit run $1 --server.port ${server_port} --server.address 0.0.0.0 \
    --server.enableCORS=false --server.enableWebsocketCompression=false