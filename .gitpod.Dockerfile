FROM gitpod/workspace-full

# Run explorer
USER root

RUN mkdir -p ~/explorer
RUN cd ~/explorer
RUN git clone https://github.com/blockstack/explorer.git

# Installing dependencies
RUN yarn

# Running the app
CMD [ "yarn", "dev" ]

# Expose port 3000
EXPOSE 3000