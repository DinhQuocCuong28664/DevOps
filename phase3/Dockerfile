# 1. Use Node.js 20-alpine for lightweight and secure base image
FROM node:20-alpine

# Set environment variable to indicate production mode
ENV NODE_ENV=production

# 2. Set working directory and grant permissions for the 'node' user
WORKDIR /usr/src/app

# 3. Copy package management files
COPY package*.json ./

# 4. Install production dependencies (faster and cleaner than npm install)
RUN npm ci --only=production

# 5. Copy source code (Combined with .dockerignore to skip local node_modules)
COPY --chown=node:node . .

# 6. Create uploads directory and ensure 'node' user has write permissions
RUN mkdir -p public/uploads && chown -R node:node public/uploads

# 7. Use 'node' user instead of root to increase security 
USER node

# 8. Expose port 3000
EXPOSE 3000

# 9. Application run command
CMD ["node", "main.js"]
