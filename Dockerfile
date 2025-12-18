# Use the official Node multi-arch image (works on Raspberry Pi 32/64-bit)
FROM node:20-slim

# Create app directory
WORKDIR /usr/src/app

# Install build dependencies only while installing npm packages
COPY package*.json ./
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential ca-certificates curl \
    && npm ci --production \
    && apt-get remove -y build-essential \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /root/.npm

# Copy app source and set correct ownership for the non-root user
COPY . .
RUN chown -R node:node /usr/src/app

# Default port (can be overridden with PORT env var)
EXPOSE 3000
ENV PORT=3000

# Run as the non-root 'node' user provided by the base image
USER node
CMD ["node", "server.js"]
