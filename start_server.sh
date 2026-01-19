#!/bin/bash
# Paper Review Platform - Server Starter

cd "$(dirname "$0")"

echo "Installing dependencies..."
npm install 2>/dev/null

echo ""
echo "Starting OpenCode API server..."
node opencode-server.js api
