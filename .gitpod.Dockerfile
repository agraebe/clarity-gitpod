FROM gitpod/workspace-full

# Clone explorer
RUN mkdir -p ~/explorer
RUN cd ~/explorer
RUN git clone https://github.com/blockstack/explorer.git
WORKDIR ~/explorer

# Build sources
ENV NODE_ENV production
RUN yarn
RUN yarn build
RUN yarn cache clean

# Expose port 3000
EXPOSE 3000

# Run build
CMD [ "yarn", "start" ]