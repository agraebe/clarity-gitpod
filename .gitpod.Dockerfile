FROM gitpod/workspace-full

# Clone explorer
RUN mkdir -p /home/gitpod/explorer
RUN cd /home/gitpod/explorer
RUN git clone https://github.com/blockstack/explorer.git
WORKDIR /home/gitpod/explorer

# Build sources
ENV MOCKNET_API_SERVER https://crashy-stacky.zone117x.com
ENV TESTNET_API_SERVER https://sidecar.staging.blockstack.xyz
RUN yarn

# Expose port 3000
EXPOSE 3000

# Run build
CMD [ "yarn", "dev" ]