FROM debian:buster as build

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    make \
    build-essential \
    libssl-dev\
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    ca-certificates

RUN groupadd -g 1000 appuser \
    && useradd -m -u 1000 -g appuser -s /sbin/nologin appuser 

USER appuser

ENV PYENV_ROOT="/home/appuser/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv 

# Install latest versions of Python 3.6, 3.7, 3.8 and 3.9

RUN py36=$(pyenv install -l | grep " 3\.6\." | tail -n1 | tr -d " \n\t\r") \
    py37=$(pyenv install -l | grep " 3\.7\." | tail -n1 | tr -d " \n\t\r") \
    py38=$(pyenv install -l | grep " 3\.8\." | tail -n1 | tr -d " \n\t\r") \
    py39=$(pyenv install -l | grep " 3\.9\." | tail -n1 | tr -d " \n\t\r") \
    && pyenv install "$py36" \
    && pyenv install "$py37" \
    && pyenv install "$py38" \
    && pyenv install "$py39" \
    && pyenv global "$py36" "$py37" "$py38" "$py39"

FROM debian:buster-slim as final

COPY --from=build /home/appuser/.pyenv /pyenv
# Change default shell to bash
SHELL ["/bin/bash", "-c"] 

ENV PYENV_ROOT="/pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"

RUN apt-get update && apt-get install -y libssl-dev \
    && echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc \
    # Reload shell
    # default is Python 3.6
    && source ~/.bashrc && python -m pip install tox tox-pyenv && python -m pip install pip --upgrade

LABEL org.opencontainers.image.source https://github.com/Nicceboy/tox-with-multipython
