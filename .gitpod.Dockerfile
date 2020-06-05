FROM gitpod/workspace-full

USER gitpod

RUN nvm install 13

RUN mkdir /sidecar \      
           cd /sidecar \        
           https://github.com/blockstack/stacks-blockchain-sidecar.git \
           npm install \
           npm run dev:integrated

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && \
#     sudo apt-get install -yq bastet && \
#     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/config-docker/
