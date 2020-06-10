FROM gitpod/workspace-full

# Clone explorer
RUN git -C /home/gitpod clone https://github.com/blockstack/explorer.git

## Build sources
RUN yarn --cwd /home/gitpod/explorer

## Setup start script
RUN echo '#!/bin/bash\n\
yarn --cwd /home/gitpod/explorer dev' > /home/gitpod/explorer/explorer_start.sh
RUN chmod +x /home/gitpod/explorer/explorer_start.sh
ENV PATH="/home/gitpod/explorer:$PATH"

# Install docker compose
RUN mkdir -p /home/gitpod/docker
RUN cd /home/gitpod/docker
RUN curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /home/gitpod/docker/docker-compose
RUN chmod +x /home/gitpod/docker/docker-compose
ENV PATH="/home/gitpod/docker:$PATH"

## Start docker deamon
CMD ["service", "docker", "start"]

# Clone Sidecar
RUN git -C /home/gitpod clone https://github.com/blockstack/stacks-blockchain-sidecar.git

## Build sources
RUN npm install --prefix /home/gitpod/stacks-blockchain-sidecar

## Setup start script
RUN echo '#!/bin/bash\n\
npm run --prefix /home/gitpod/stacks-blockchain-sidecar dev:integrated' > /home/gitpod/stacks-blockchain-sidecar/sidecar_start.sh
RUN chmod +x /home/gitpod/stacks-blockchain-sidecar/sidecar_start.sh
ENV PATH="/home/gitpod/stacks-blockchain-sidecar:$PATH"

# Clone REPL
RUN git -C /home/gitpod clone https://github.com/lgalabru/clarity-repl.git

## Install cargo
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
SHELL ["/bin/bash", "-c", "source $HOME/.cargo/env"]

## Build sources
SHELL ["/bin/bash", "-c", "cargo install --bin clarity-repl --path /home/gitpod/clarity-repl"]