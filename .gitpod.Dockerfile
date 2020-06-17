FROM quay.io/blockstack/blockstack-core:latest as corenode

FROM gitpod/workspace-postgres

COPY --from=corenode /bin/stacks-node /bin/


# Clone explorer
RUN git -C /home/gitpod clone https://github.com/blockstack/explorer.git

## Build sources
RUN yarn --cwd /home/gitpod/explorer

## Setup start script
RUN echo '#!/bin/bash\n\
yarn --cwd /home/gitpod/explorer dev' > /home/gitpod/explorer/explorer_start.sh
RUN chmod +x /home/gitpod/explorer/explorer_start.sh
ENV PATH="/home/gitpod/explorer:$PATH"

# Clone Sidecar
RUN git -C /home/gitpod clone https://github.com/blockstack/stacks-blockchain-sidecar.git

## Build sources
RUN npm install --prefix /home/gitpod/stacks-blockchain-sidecar

## Setup start script
RUN echo '#!/bin/bash\n\
npm run --prefix /home/gitpod/stacks-blockchain-sidecar start' > /home/gitpod/stacks-blockchain-sidecar/sidecar_start.sh
RUN chmod +x /home/gitpod/stacks-blockchain-sidecar/sidecar_start.sh
ENV PATH="/home/gitpod/stacks-blockchain-sidecar:$PATH"

## Sidecar env vars
ENV PG_HOST postgres
ENV PG_PORT 5432
ENV PG_USER postgres
ENV PG_PASSWORD postgres
ENV PG_DB stacks_core_sidecar
ENV STACKS_SIDECAR_EVENT_PORT 3700
ENV STACKS_SIDECAR_EVENT_HOST http://0.0.0.0
ENV STACKS_SIDECAR_API_PORT 3999
ENV STACKS_SIDECAR_API_HOST 0.0.0.0
ENV STACKS_SIDECAR_DB pg
ENV STACKS_CORE_RPC_HOST stacks-blockchain
ENV STACKS_CORE_RPC_PORT 20443
ENV NODE_ENV development

# Stacks-node env vars
ENV STACKS_EVENT_OBSERVER http://127.0.0.1:3700/

RUN echo 

# Clone REPL
RUN git -C /home/gitpod clone https://github.com/lgalabru/clarity-repl.git

## Setup init script
RUN echo '#!/bin/bash\n\
cargo install --bin clarity-repl --path /home/gitpod/clarity-repl && clarity-repl' > /home/gitpod/clarity-repl/repl_init.sh
RUN chmod +x /home/gitpod/clarity-repl/repl_init.sh
ENV PATH="/home/gitpod/clarity-repl:$PATH"