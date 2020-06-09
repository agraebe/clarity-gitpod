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

# Clone Sidecar
RUN mkdir -p /home/gitpod/sidecar
RUN cd /home/gitpod/sidecar
RUN git clone https://github.com/blockstack/stacks-blockchain-sidecar.git
WORKDIR /home/gitpod/sidecar

## Build sources
RUN npm install

## Setup start script
RUN echo '#!/bin/bash\n\
npm run --prefix /home/gitpod/sidecar dev:integrated' > /home/gitpod/sidecar/sidecar_start.sh
RUN chmod +x /home/gitpod/sidecar/sidecar_start.sh
ENV PATH="/home/gitpod/sidecar:$PATH"