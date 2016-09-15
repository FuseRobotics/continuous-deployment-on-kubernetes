#!/bin/bash

if [ -n "$NPM_PROXY" ]; then
  echo "Setting NPM proxy to ${NPM_PROXY}"
  npm config set proxy $NPM_PROXY
  npm config set https-proxy $NPM_PROXY
  npm config set strict-ssl false
else
  echo "No NPM_PROXY set, skipping."
fi

if [ -n "$NPM_REGISTRY" ]; then
  echo "Setting NPM registry to ${NPM_REGISTRY}"
  npm set ca null
  npm set registry ${NPM_REGISTRY}
fi
