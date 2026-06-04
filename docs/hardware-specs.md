# Hardware Specifications

This document outlines the hardware used for running the local AI inference and agent orchestration system, along with observed performance characteristics.

## Tested Hardware Configuration

- **CPU**: AMD Ryzen 7 7700X (8 cores / 16 threads)
- **GPU**: NVIDIA RTX 5060 Ti 16GB
- **System RAM**: 32GB
- **Storage**: NVMe SSD (sufficient for model storage and fast loading)
- **Operating System**: Windows 11 Pro

This is a consumer-grade desktop setup, not a server or workstation-class machine.

## Performance Characteristics

With proper optimization (TurboQuant, appropriate quantization, and expert offloading), the system can run two models simultaneously with the following approximate characteristics:

- **Total VRAM usage**: ~13–15 GB under typical dual-model workloads
- **Context length**: Flexible depending on model size and quantization (longer contexts possible with more aggressive compression)
- **Stability**: Good long-session stability when properly tuned
- **Thermal / Power**: Manageable on a well-cooled desktop system

Exact performance varies based on:
- Model size and quantization level
- Context length
- Number of concurrent requests
- Specific agent workload characteristics

## Why This Hardware Works

The combination of a strong CPU, modern GPU with 16GB VRAM, and sufficient system RAM allows for:
- Running capable open models locally
- Maintaining a dual-model setup without constant swapping
- Supporting agent orchestration workloads that involve both reasoning and tool use

This demonstrates that meaningful local AI infrastructure and autonomous agent systems can be run on relatively accessible consumer hardware.

## Limitations

- Not suitable for very large models without heavy quantization
- VRAM becomes the primary constraint when scaling to more models or longer contexts
- Single-machine deployment (no easy horizontal scaling)

## Notes

All performance observations are based on real usage for development and agent-driven automation tasks. Results can vary significantly depending on workload and configuration.

See `model-optimization.md` and `dual-llm-deployment.md` for details on how this hardware is utilized effectively.
