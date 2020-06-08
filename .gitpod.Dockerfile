FROM gitpod/workspace-full

# Run explorer
USER root

RUN mkdir /home/explorer \      
           cd /home/explorer \        
           git clone https://github.com/blockstack/explorer.git

#Set working directory
WORKDIR /home/explorer

# Installing dependencies
RUN yarn

# Running the app
CMD [ "yarn", "dev" ]