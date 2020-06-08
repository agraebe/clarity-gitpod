FROM gitpod/workspace-full

# Run explorer
USER root

RUN mkdir -p ~/explorer
RUN cd /home/explorer
RUN git clone https://github.com/blockstack/explorer.git

# Installing dependencies
RUN yarn

# Running the app
CMD [ "yarn", "dev" ]