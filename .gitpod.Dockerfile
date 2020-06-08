FROM gitpod/workspace-full

# Clone explorer
RUN mkdir -p /home/gitpod/explorer
RUN cd /home/gitpod/explorer
RUN git clone https://github.com/blockstack/explorer.git
WORKDIR /home/gitpod/explorer

# Build sources
RUN chmod 755 /home/gitpod/explorer
ENV NODE_ENV production
RUN yarn
RUN yarn build
RUN yarn cache clean

# Expose port 3000
EXPOSE 3000

# Run build
CMD [ "yarn", "start" ]