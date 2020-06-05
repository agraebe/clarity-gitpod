FROM gitpod/workspace-full

USER gitpod

### Node.js ###
ENV NODE_VERSION=13.14.0
RUN nvm install ${NODE_VERSION}