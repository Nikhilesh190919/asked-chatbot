# Multi-stage build for React app
# Build context should be set to 'frontend' directory in App Runner

FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY frontend/package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY frontend/ ./

# Build the app
RUN npm run build

# Production stage
FROM node:18-alpine

WORKDIR /app

# Install serve globally
RUN npm install -g serve

# Copy built app from builder stage
COPY --from=builder /app/build ./build

# Expose port 8080 (App Runner default)
EXPOSE 8080

# Start the server
CMD ["serve", "-s", "build", "-l", "8080"]

