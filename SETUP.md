# Setup Guide

This guide covers how to set up the local AI inference and agent orchestration environment described in this repository.

## Hardware Requirements

Tested configuration:

- **CPU**: AMD Ryzen 7 7700X (8-core)
- **GPU**: NVIDIA RTX 5060 Ti 16GB
- **RAM**: 32GB
- **OS**: Windows 11 Pro

The setup is designed to run two models simultaneously with stable performance and headroom for agent orchestration.

## Prerequisites

- Git
- Python 3.10+ (recommended)
- NVIDIA drivers and CUDA toolkit (matching your GPU)
- Build tools for compiling llama.cpp (Visual Studio Build Tools or MinGW on Windows)

## Step 1: Clone the Repository

```bash
git clone https://github.com/BChollett/local-ai-agents.git
cd local-ai-agents
```

## Step 2: Build llama.cpp with TurboQuant Support

TurboQuant provides KV cache compression and expert offloading, which significantly improves memory efficiency (especially for MoE models).

```bash
# Clone llama.cpp
 git clone https://github.com/ggerganov/llama.cpp.git
 cd llama.cpp

# Build with CUDA and TurboQuant support (adjust flags as needed)
make LLAMA_CUDA=1

# Or on Windows with Visual Studio
cmake -B build -DGGML_CUDA=ON
cmake --build build --config Release
```

See the official llama.cpp documentation for detailed build instructions for your platform.

## Step 3: Download Models

Recommended approach:

- Use `huggingface-cli` or direct downloads from Hugging Face
- Prefer `.safetensors` or GGUF quantized versions
- Place models in a dedicated `models/` directory (not tracked in this repo)

Example structure:
```
models/
├── Qwen3.5-32B-Q4_K_M.gguf
└── Gemma-2-9B-Q5_K_M.gguf
```

## Step 4: Configure Dual-Model Deployment

The system runs two models on separate ports:

- **Primary model** (port 11434 by default): Higher capability model for complex reasoning and coding tasks
- **Secondary model** (port 11435 by default): Lighter/faster model optimized for tool use and orchestration

Edit the launch scripts in `scripts/` or create your own configuration files to match your model paths and desired ports.

## Step 5: Launch the Dual-Model Setup

```bash
# Example launch (adjust paths and ports as needed)
./scripts/start-dual-models.sh
```

Once running, you should have two llama.cpp server instances listening on their respective ports.

## Step 6: Verify the Setup

Test basic inference:

```bash
curl http://localhost:11434/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "Explain TurboQuant in one sentence.",
    "max_tokens": 50
  }'
```

Repeat for the secondary port (usually 11435).

## Resource Usage Notes

- Expect ~13-15 GB VRAM usage with both models loaded (depending on quantization and context length)
- Monitor GPU temperature and power draw during long sessions
- The dual-model pattern allows specialization while keeping total resource usage manageable

## Agent Framework Setup

After inference is running:

1. Install Hermes Agent and/or OpenClaw according to their official documentation
2. Configure the agent runtime to point to your local model endpoints
3. Register custom tools as needed
4. Set up memory and skill persistence (see Hermes documentation)

## Troubleshooting

- **Out of memory errors**: Reduce context length, use more aggressive quantization, or lower batch size
- **Slow generation**: Check GPU utilization and ensure TurboQuant/expert offloading is enabled
- **Port conflicts**: Change the ports in your launch configuration
- **Model loading failures**: Verify file paths and that the models are in supported GGUF or safetensors format

## Next Steps

Once the base inference and agent frameworks are running, you can explore the orchestration patterns and automation examples in the `examples/` and `docs/` directories.

See `ARCHITECTURE.md` for the overall system design.
