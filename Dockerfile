ARG NODE_VERSION=16.2.0

###
# 1. Dependencies
###

FROM node:${NODE_VERSION} as dependencies

WORKDIR /home/node/

ENV NODE_ENV development

COPY tsconfig.json package.json *package-lock.json ./
RUN npm ci

COPY ts ./ts
# "prod-build" on production
RUN npm run setup && \
	npm prune --production

###
# 2. Application
###

FROM node:${NODE_VERSION}-alpine
WORKDIR /home/node/

COPY --from=dependencies /home/node/node_modules node_modules
COPY --from=dependencies /home/node/built built

COPY package.json ./

ENV PATH="$PATH:/home/node/node_modules/.bin"

RUN chown -R node:node /home/node
USER node

ENV NODE_ENV production

# "start" on production
CMD ["npm", "run", "start"]