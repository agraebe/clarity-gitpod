FROM gitpod/workspace-full

# Run explorer
USER root

RUN mkdir /explorer \      
           cd /explorer \        
           git clone https://github.com/blockstack/explorer.git

#Set working directory
WORKDIR /explorer

# Installing dependencies
RUN yarn

# Running the app
CMD [ "yarn", "dev" ]