# Use an official Node.js runtime as a parent image
FROM oven/bun:latest

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN bun install

# Copy the rest of the application code
COPY . .

# Expose the port your application runs on
EXPOSE 3000

# Define the command to run when the container starts
CMD ["bun", "start"]