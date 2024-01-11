# Stage 1: Build the Nuxt.js application
FROM node:20.11.0 AS build-stage

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Nuxt.js dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the Nuxt.js application for production
RUN npm run build

# Stage 2: Serve the production build using a lightweight web server
FROM nginx:alpine AS production-stage

# Copy the production build from the build-stage to the NGINX container
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose port 80 for the NGINX server
EXPOSE 80

# Start the NGINX server
CMD ["nginx", "-g", "daemon off;"]
