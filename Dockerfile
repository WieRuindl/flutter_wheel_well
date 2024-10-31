# # Step 1: Use the official Flutter image to build the Flutter web app
FROM ghcr.io/cirruslabs/flutter:3.24.3 AS build
# # Set the working directory inside the container
# WORKDIR /app
# # Copy the pubspec.yaml and pubspec.lock files to cache dependencies
COPY pubspec.* ./
# # Get the Flutter dependencies
RUN flutter pub get
# RUN flutter pub upgrade
# # Copy the rest of the application code to the container
COPY . .
# # Build the Flutter web app
RUN flutter build web --release

# Use the official NGINX image from DockerHub
FROM nginx:alpine
# Copy the Flutter web build files to the NGINX web directory
COPY --from=build build/web /usr/share/nginx/html
COPY --from=build nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 5555
CMD ["nginx", "-g", "daemon off;"]