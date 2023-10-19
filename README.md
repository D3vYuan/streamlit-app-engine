<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h2 align="center">Streamlit Application - App Engine Deployment</h2>
  <p align="center">
    Case Study - Streamlit Application (App Engine Deployment)
  </p>
  <!--div>
    <img src="images/profile_pic.png" alt="Logo" width="80" height="80">
  </div-->
</div>

---

<!-- TABLE OF CONTENTS -->

## Table of Contents

<!-- <details> -->
<ol>
    <li>
        <a href="#about-the-project">About The Project</a>
    </li>
    <li><a href="#setup">Setup</a></li>
    <li><a href="#implementation">Implementation</a></li>
    <li>
      <a href="#usage">Usage</a>
      <ul>
            <li><a href="#via-docker">Via Docker</a></li>
            <li><a href="#via-app-engine">Via App Engine</a></li>
        </ul>
    </li>
    <li><a href="#challenges">Challenges</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
</ol>
<!-- </details> -->

---

<!-- ABOUT THE PROJECT -->

## About The Project

This project is created to showcase how we can deploy `Streamlit` application to `App Engine Flex`.

The following are some of the requirements:

- Dockerize `Streamlit` application
- Deploy `Streamlit` application to `App Engine Flex`

<p align="right">(<a href="#top">back to top</a>)</p>

---

<!-- Setup -->

## Setup

Base on the requirements, the following components are required to be setup:

- XXXXXXXXXXXXXX

<p align="right">(<a href="#top">back to top</a>)</p>

---

## Implementation

Base on the requirements, the following are the tasks in the process:

- Create a sample `streamlit` application

<p align="right">(<a href="#top">back to top</a>)</p>

### Sample Streamlit Application

In order to test the deployment, we will create a sample application that will have 2 buttons, 1 to add to the counter and the other to reset the counter.

| ![Sample Streamlit Appplication][streamlit-app-demo] |
| :--------------------------------------------------: |
|            _Sample Streamlit Application_            |

<p align="right">(<a href="#top">back to top</a>)</p>

---

<!-- USAGE EXAMPLES -->

## Usage

The following are some of the usage:

- `via-docker` - Deploy `Streamlit` application to `Docker`
- `via-app-engine` - Deploy `Streamlit` application to `App Engine Flex`

<p align="right">(<a href="#top">back to top</a>)</p>

### Via Docker

#### Dockerfile

The following is the `Dockerfile` configuration: <br/>
More information for the virtual environment in python runtime can be found [here][streamlit-app-engine-customize-python-runtime] <br>

```docker
# Use the docker image for the app engine python runtime environment
FROM gcr.io/google-appengine/python

# Update the dependencies within the python runtime environment
RUN apt-get update -y && apt-get upgrade -y

# Create a virtualenv for dependencies. This isolates these packages from
# system-level packages.
# Use -p python3 or -p python3.7 to select python version. Default is version 2.
RUN virtualenv /env -p python3

# Setting these environment variables are the same as running
# source /env/bin/activate.
ENV VIRTUAL_ENV /env
ENV PATH /env/bin:$PATH

# Copy the application into the python runtime environment
WORKDIR /app
COPY . ./

# Download python libraries for the application
RUN pip install --upgrade pip
RUN pip install --upgrade -r requirements.txt

# Expose the port for the application
EXPOSE 8080

# Command to start the application
ENTRYPOINT ["streamlit", "run", "streamlit_101.py", "--server.port=8080", "--server.address=0.0.0.0"]
```

<p align="right">(<a href="#top">back to top</a>)</p>

#### Execution

Run the following command to build a docker image using the `Dockerfile`: <br/>

[NOTE]

- Replace `<DOCKER_IMAGE>` with the `Docker` image name

```bash
# Build the docker image using the Dockerfile in the current directory
docker build -t <DOCKER_IMAGE> .

# Show all the available docker images
docker images
```

| ![Streamlit Docker Image][streamlit-app-docker-image] |
| :---------------------------------------------------: |
|         _Streamlit Application Docker Image_          |

<p align="right">(<a href="#top">back to top</a>)</p>

#### Verification

Run the following command to create a `Docker` container with the image that we built: <br/>

[NOTE]

- Replace `<SOURCE_PORT>` with the host port, and do open the firewall rule to allow the traffic to the this port
- Replace `<DESTINATION_PORT>` with the container port
- Replace `<DOCKER_IMAGE>` with the `Docker` image name specified during the build

```bash
# Spin up the container
docker run -itd --rm -p <SOURCE_PORT>:<DESTINATION_PORT> <DOCKER_IMAGE>

# Check the container status
docker ps -a
```

Once the container is up and running, access the application using the host ip address and the source port.

[NOTE]

- If the application stuck at please wait, you can consider disabling the properties (_enableCORS_, _enableWebsocketCompression_, _enableXsrfProtection_) mentioned [here][streamlit-app-please-wait-issue] in the `Dockerfile`

| ![Streamlit Docker Appplication][streamlit-app-docker-demo] |
| :---------------------------------------------------------: |
|               _Streamlit Docker Application_                |

<p align="right">(<a href="#top">back to top</a>)</p>

### Via App Engine

#### app.yaml

The following is the `app.yaml` [configuration][streamlit-app-engine-yaml-configuration]: <br/>
[NOTE]

- We do not need the `entrypoint` as we are using the `Dockerfile` and the `entrypoint` is specify in it

```yaml
# Running the app engine flex
runtime: custom
env: flex

# Name of the service
service: streamlit-101

# Python runtime for the app engine
runtime_config:
  operating_system: "ubuntu22"
  runtime_version: "3.9"

# Auto scaling configuration
automatic_scaling:
  min_num_instances: 1
  max_num_instances: 2
  cool_down_period_sec: 180
  cpu_utilization:
    target_utilization: 0.8
  target_concurrent_requests: 100

# Machine Types
resources:
  cpu: 1
  memory_gb: 0.5
  disk_size_gb: 10

# Network configuration
network:
  name: log-vpc
  subnetwork_name: log-vpc
  session_affinity: true
  forwarded_ports:
    - 8501:8080
```

<p align="right">(<a href="#top">back to top</a>)</p>

#### Execution

Run the following command to publish the application in `App Engine` using the `app.yaml`:

```bash
gcloud app deploy app.yaml
```

<p align="right">(<a href="#top">back to top</a>)</p>

#### Verification

Once the application is deployed to `App Engine`, access the application from the console.

| ![App Engine Console][streamlit-app-app-engine-console] |
| :-----------------------------------------------------: |
|                  _App Engine Console_                   |

The address of the application should looks like the following:

| ![App Engine Streamlit Appplication][streamlit-app-app-engine-demo] |
| :-----------------------------------------------------------------: |
|                 _Streamlit App Engine Application_                  |

<p align="right">(<a href="#top">back to top</a>)</p>

---

<!-- Challenges -->

## Challenges

The following are some challenges encountered:

- <p align="right">(<a href="#top">back to top</a>)</p>

<!-- ### Challenge #1: Updating BigQuery values from Dataproc
<br/>

**Observations** <br/>
<br/>More information can be found [here][ref-bigquery-client-write]

<br/>

**Resolution** <br/>
<br/>

<p align="right">(<a href="#top">back to top</a>)</p> -->

---

<!-- ACKNOWLEDGMENTS -->

## Acknowledgments

- [Readme Template][template-resource]
- [Streamlit App Engine Deployment Tutorial][streamlit-app-engine-deployment]
- [Streamlit App Engine Quickstart][streamlit-app-engine-quickstart]
- [Streamlit App Engine Custom Runtime][streamlit-app-engine-custom-runtime]
- [Streamlit App Engine Python Runtime][streamlit-app-engine-python-runtime]
- [Streamlit App Engine Python Runtime][streamlit-app-engine-python-runtime]
- [Streamlit App Engine Customize Python Runtime][streamlit-app-engine-customize-python-runtime]

<p align="right">(<a href="#top">back to top</a>)</p>

---

<!-- MARKDOWN LINKS & IMAGES -->

[template-resource]: https://github.com/othneildrew/Best-README-Template/blob/master/README.md
[streamlit-app-engine-deployment]: https://www.whitphx.info/posts/20211214-streamlit-app-engine/
[streamlit-app-engine-quickstart]: https://cloud.google.com/appengine/docs/flexible/python/create-app#mac-os-linux
[streamlit-app-engine-custom-runtime]: https://cloud.google.com/appengine/docs/flexible/custom-runtimes/build#listening_to_port_8080
[streamlit-app-engine-python-runtime]: https://cloud.google.com/appengine/docs/flexible/python/runtime
[streamlit-app-engine-customize-python-runtime]: https://cloud.google.com/appengine/docs/flexible/python/customizing-the-python-runtime
[streamlit-app-engine-yaml-configuration]: https://cloud.google.com/appengine/docs/flexible/reference/app-yaml?tab=python
[streamlit-app-demo]: ./images/streamlit_application_demo.png
[streamlit-app-docker-image]: ./images/streamlit_application_docker_image.png
[streamlit-app-docker-demo]: ./images/streamlit_application_docker_demo.png
[streamlit-app-app-engine-console]: ./images/streamlit_application_app_engine_console.png
[streamlit-app-app-engine-demo]: ./images/streamlit_application_app_engine_demo.png
[streamlit-app-please-wait-issue]: https://docs.streamlit.io/knowledge-base/deploy/remote-start#symptom-2-the-app-says-please-wait-forever
