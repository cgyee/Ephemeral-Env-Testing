# Use an official Node.js runtime as a parent image
FROM oven/bun:latest

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json .

# Copy the rest of the application code
COPY index.ts .

# Install application dependencies
RUN bun install

# Expose the port your application runs on
EXPOSE 3000

# Define the command to run when the container starts
CMD ["bun", "start"]