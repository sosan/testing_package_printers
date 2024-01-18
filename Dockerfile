ARG NODE_VERSION=16.19.0
FROM node:${NODE_VERSION}-alpine AS base
WORKDIR /usr/src/app
RUN apk add --no-cache \
    build-base \
    python3 \
    python3-dev \
    cups \
    cups-libs \
    cups-dev \
    eudev-dev
RUN npm install -g node-gyp

FROM base AS deps
# pa no andar con el package.json.lock
RUN --mount=type=bind,source=package.json,target=package.json \
    --mount=type=cache,target=~/.npm \
    npm install

FROM base AS final
# ----
# pa NO estar probando packages desde el package.json
# RUN npm install printer --target_arch=x64                                     # ------------ errores
# RUN npm install printer --msvs_version=2013  --build-from-source=node_printer # ------------ errores
# RUN npm install @thiagoelg/node-printer                                       # ------------ sin errores
# ----

COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY example.js example.js
CMD ["node", "example.js"]
# ENTRYPOINT ["node", "node_modules/@thiagoelg/node-printer/examples/getPrinters.js"]
