#!/bin/bash

# Example script for launching dual LLM servers
# Customize paths, ports, and model names for your setup

# Primary model (stronger reasoning model)
PRIMARY_MODEL="models/your-primary-model.gguf"
PRIMARY_PORT=11434

# Secondary model (lighter / tool-focused model)
SECONDARY_MODEL="models/your-secondary-model.gguf"
SECONDARY_PORT=11435

# Common llama.cpp server flags (adjust as needed)
COMMON_FLAGS="--ctx-size 8192 --n-gpu-layers 99 --host 0.0.0.0"

echo "Starting Primary Model on port $PRIMARY_PORT..."
./llama-server \
    -m "$PRIMARY_MODEL" \
    --port $PRIMARY_PORT \
    $COMMON_FLAGS &

PRIMARY_PID=$!

echo "Starting Secondary Model on port $SECONDARY_PORT..."
./llama-server \
    -m "$SECONDARY_MODEL" \
    --port $SECONDARY_PORT \
    $COMMON_FLAGS &

SECONDARY_PID=$!

echo "Both models started."
echo "Primary PID: $PRIMARY_PID"
echo "Secondary PID: $SECONDARY_PID"

echo "Press Ctrl+C to stop both servers."

wait
