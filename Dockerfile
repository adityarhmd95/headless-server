# Use an official minimal Linux image
FROM debian:bullseye-slim

# Set the working directory inside the container
WORKDIR /app

# Install necessary dependencies
RUN apt-get update && apt-get install -y libfontconfig1 libenet-dev

# Copy all project files (including server.gd)
COPY . .

# Ensure the server binary is executable
RUN chmod +x ./linux-server.x86_64

# Check if the binary file has correct permissions
RUN ls -l ./linux-server.x86_64

# Expose the dynamic port Railway assigns
EXPOSE 8080

# Run the Godot server in headless mode using the Railway port
CMD ["sh", "-c", "echo 'Server starting on port $PORT' && ./linux-server.x86_64 --main-pack ./linux-server.pck --headless --rendering-driver opengl3 --server-port $PORT"]