# Multi-Python with Tox for testing

A "lightweight" Docker image with multiple Python versions and [tox](https://tox.readthedocs.io/en/latest/) installed - for application testing purposes. Additionally plugin [tox-pyenv](https://github.com/stavxyz/tox-pyenv) has been installed.

![build](https://img.shields.io/github/workflow/status/Nicceboy/tox-with-multipython/Docker) ![License](https://img.shields.io/github/license/Nicceboy/tox-with-multipython) 


Currently supports following *latest* minor versions:

  * 3.6.x
  * 3.7.x
  * 3.8.x
  * 3.9.x

Version installations are handled with [pyenv.](https://github.com/pyenv/pyenv) Check it out for managing specific versions of the Python if needed.

By default, Python binaries are named as `python3.6`, `python3.7`, `python3.8` and `python3.9`. Python 3.6.x is default.

Current base image is Debian Buster (10).

See Dockerfile in [here.](Dockerfile)

> Image is updated once in a week with cron job

## Getting started

Image can be imported as following:

```Dockerfile
FROM ghcr.io/nicceboy/multipython:latest

# Recommended to change shell for bash that pyenv works correctly
SHELL ["/bin/bash", "-c"]

# When using Python/tox commands, bashrc must be sourced
RUN source ~/.bashrc && do your stuff

```

Pip must be used as Python module e.g. `python -m pip install pip --upgrade`.

See package in [here.](https://github.com/users/Nicceboy/packages/container/package/multipython)


## Tox.ini example

Example tox file could look something like this:
```ini
[tox]
envlist = py36,py37,py38,py39

[testenv]
platform = linux2|darwin|linux
deps = 
    pytest
    pytest-cov
install_command =
    pip install -U {opts} {packages}
# add posargs from command line
commands = 
        pytest {posargs} 

[pytest]
addopts = -v
markers = "not-in-use"
```

## License

MIT
