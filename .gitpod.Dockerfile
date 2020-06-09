FROM gitpod/workspace-full

# Clone explorer
RUN mkdir -p /home/gitpod/explorer
RUN cd /home/gitpod/explorer
RUN git clone https://github.com/blockstack/explorer.git
WORKDIR /home/gitpod/explorer

## Build sources
RUN yarn

## Setup start script
RUN echo '#!/bin/bash\n\
yarn --cwd /home/gitpod/explorer dev' > /home/gitpod/explorer/explorer_start.sh
RUN chmod +x /home/gitpod/explorer/explorer_start.sh
ENV PATH="/home/gitpod/explorer:$PATH"

# Install docker compose
RUN mkdir -p /home/gitpod/docker
RUN cd /home/gitpod/docker
WORKDIR /home/gitpod/docker
RUN curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /home/gitpod/docker/docker-compose
RUN chmod +x /home/gitpod/docker/docker-compose
ENV PATH="/home/gitpod/docker:$PATH"

# Clone Sidecar
RUN cd /home/gitpod
RUN git clone https://github.com/blockstack/stacks-blockchain-sidecar.git
WORKDIR /home/gitpod/stacks-blockchain-sidecar

## Setup start script
RUN echo '#!/bin/bash\n\
npm run --prefix /home/gitpod/stacks-blockchain-sidecar dev:integrated' > /home/gitpod/stacks-blockchain-sidecar/sidecar_start.sh
ENV PATH="/home/gitpod/stacks-blockchain-sidecar:$PATH"

## Build sources
RUN npm install