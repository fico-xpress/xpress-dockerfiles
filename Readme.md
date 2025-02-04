# Creating FICO Xpress Docker image and container

To create a FICO Xpress image and container, Dockerfiles are provided in this repository.
We provide a Dockerfile to install FICO Xpress Solver distribution with FICO Xpress Mosel and other interfaces, and a Dockerfile to install the FICO Xpress Python Solver interface.

## Licensing

These Dockerfiles include FICO Xpress software.
By downloading any of these Dockerfiles, you agree to the Community License terms of the [Xpress Shrinkwrap License Agreement](https://community.fico.com/s/contentdocument/06980000002h0i5AAA) with respect to the included FICO Xpress software.

The images created by the Dockerfiles also contain other, separate, distinct software which may be subject to other licenses (such as Bash, etc. from the base distribution, along with any direct or indirect dependencies of the primary software being contained).
It is the image user's responsibility to ensure that any use complies with the relevant licenses for all software contained within.

## Python Dockerfile

Xpress Python Dockerfile can be found in the folder `python` and can be used to create an image from the Dockerfile and running a container.

To create an image, a version for both Python and Xpress must be speficied.
This can be done, for example, by running the following command in the directory containing the Dockerfile:

```bash
docker image build \
    --build-arg XPRESS_VERSION=9.5.3 \
    --build-arg PYTHON_VERSION=3.12.0 \
    --tag xpress/python .
```

You can create a container and enter Python standard shell with the following command:
```bash
docker run --interactive --tty xpress/python
```

The Xpress Python package comes with a community license by default.

The list of Python versions officially supported for each version of Xpress can be found in the table below.

| Xpress     |      Supported Python Version                     |
|:----------:|:------------------------------------------------:|
| 9.5        |  3.12<br>3.11<br>3.10<br>3.9<br>3.8              |
| 9.4        |  3.12<br>3.11<br>3.10<br>3.9<br>3.8              |
| 9.3        |  3.11<br>3.10<br>3.9<br>3.8                      |
| 9.2        |  3.11<br>3.10<br>3.9<br>3.8                      |

While other combinations may be used, the resulting image might be unstable.

## Dockerfile for FICO Xpress distribution
The Dockerfile for the distribution should be placed into the same folder as the ```install.sh``` install script, Kalis terms and conditions ```kalis_license.txt``` and tarball.

After creating a user account (free of charge) and logging in to the [FICO Xpress Optimization Community](https://community.fico.com/s/optimization), you can download the Linux x86_64 tarball by searching for the download 'FICO Xpress (Mosel & Solver) - Linux'.

### Using Docker CLI

To build the Xpress image, simply invoke docker CLI inside the folder containing the files mentioned above:

```bash
docker image build \
    --build-arg=COMPONENTS="mosel,cli" \
    --tag xpress .
```

Where ```COMPONENTS``` represents the FICO Xpress components to be installed.

The syntax is the following:

```bash
COMPONENTS                      'full' or comma separated list of the following components:
                                - mosel           install the FICO Xpress Mosel components
                                - kalis           install the FICO Xpress-Kalis constraints programming engine for Mosel
                                - cli             install the FICO Xpress commandline interface
                                - interfaces      install the FICO Xpress Optimizer interfaces
                                - dev-components  install the FICO Xpress developer libraries and headers
                                - examples        install the Examples
                                defaults to minimal install
```
By adding 'kalis' in the list of components, the user accepts the Kalis license in 'kalis_license.txt' in the installation tarball.

FICO Xpress will be installed into ```/opt/xpressmp```.

After the image is created, an interactive container can be created with the following command:

```bash
docker run --interactive --tty --name xpress_ctn --hostname xpressmp xpress /bin/bash
```

Note: A community license is available inside the image in ```/opt```.

### Example
Here is a complete workflow to install Xpress with Xpress Mosel and examples.

```bash
docker image build \
    --build-arg COMPONENTS="mosel,examples" \
    --tag xpress .
```

```bash
docker run \
    --interactive --tty --name xpress_ctn \
    --hostname xpressmp \
    xpress /bin/bash
```

# License

All files in this repository including the above mentioned Dockerfiles are licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE.txt) for the full license text.
