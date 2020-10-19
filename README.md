# Multi-Python with Tox for testing

A "lightweight" Docker image with multiple Python versions and [tox](https://tox.readthedocs.io/en/latest/) installed - for application testing purposes.

Currently supports following *latest* minor versions:

  * 3.6.x
  * 3.7.x
  * 3.8.x
  * 3.9.x

Version installations are handled with [pyenv.](https://github.com/pyenv/pyenv)

Current base image is Debian Buster (10).

See Docker file in [here.](Dockerfile)

## Getting started

Image can be imported as following:

```Dockerfile
FROM ghcr.io/Nicceboy/tox-with-multipython:latest

# Recommended to change shell for bash that pyenv works correctly
SHELL ["/bin/bash", "-c"]

# When using Python/tox commands, bashrc must be sourced
RUN source ~/.bashrc && do your stuff

```

See package in [here.](https://github.com/users/Nicceboy/packages/container/package/tox-with-multipython)

## License

MIT