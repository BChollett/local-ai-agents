# Dual-Model Deployment

This document explains the dual-model inference pattern used in this setup — running two language models simultaneously on the same machine for different purposes.

## Why Dual Models?

Running a single large model for everything has limitations:

- One model must be good at *both* complex reasoning *and* fast tool use / lighter tasks
- Resource contention when the same model handles everything
- Less flexibility to specialize

By running two models, we can:
- Use a stronger, slower model for difficult reasoning and coding tasks
- Use a lighter, faster model for tool calling, orchestration, and quick responses
- Better balance VRAM usage and responsiveness
- Improve overall system reliability and specialization

This pattern is especially useful when building autonomous agent systems that need both deep thinking and frequent tool interaction.

## Primary vs Secondary Model Roles

| Role          | Typical Strengths                     | Example Use Cases                     | Recommended Characteristics      |
|---------------|---------------------------------------|---------------------------------------|----------------------------------|
| **Primary**   | Strong reasoning, coding, complex tasks | Architecture decisions, debugging, long reasoning chains | Larger model, higher quality    |
| **Secondary** | Speed, tool use, lighter tasks        | Tool calling, simple decisions, orchestration support   | Smaller/faster model, lower latency |

The secondary model often acts as a "helper" that handles frequent, lower-complexity work so the primary model isn't constantly interrupted.

## Port Separation and Isolation

Each model runs as its own llama.cpp server instance on a different port:

- Primary model: typically port `11434`
- Secondary model: typically port `11435`

Benefits of separate ports:
- Clear isolation between models
- Easier monitoring and logging per model
- Independent configuration (context length, batch size, etc.)
- Simpler integration with agent frameworks (point different agents/tools to different endpoints)

## Resource Allocation

Key considerations when running both models:

- Total VRAM budget must accommodate both models + KV caches + overhead
- TurboQuant + expert offloading (see `model-optimization.md`) helps significantly
- The secondary model can often use more aggressive quantization or shorter context since it handles lighter work
- Monitor GPU utilization and memory during typical agent workloads

With 16 GB VRAM hardware, stable dual-model operation in the ~13–15 GB range is achievable with proper optimization.

## Integration with Agent Orchestration

The dual-model setup works particularly well with agent frameworks like Hermes and OpenClaw:

- The orchestration layer can route complex tasks to the primary model
- Simpler tool calls or intermediate steps can go to the secondary model
- This reduces latency for the overall agent workflow
- Memory and skill systems can be shared or coordinated across both models

The orchestration layer becomes the "traffic controller" that decides which model handles which part of a task.

## Practical Setup Notes

- Launch scripts should start both servers and handle basic health checks
- Configuration files should clearly separate settings for each model
- Agent frameworks need to be configured with the correct endpoints for each model
- Logging and monitoring should distinguish between the two servers

See `SETUP.md` for launch commands and basic verification.

## Stability and Monitoring

Running two models increases complexity. Recommended practices:

- Start with shorter context lengths and gradually increase
- Monitor VRAM, temperature, and tokens/sec over time
- Have clear fallback behavior if one model becomes unresponsive
- Log which model handled which tasks for debugging

Long-term stability improves significantly once good quantization and offloading settings are found.

## Trade-offs

| Advantage                     | Trade-off                          |
|-------------------------------|------------------------------------|
| Better specialization         | More complex configuration         |
| Improved responsiveness       | Higher total VRAM usage            |
| More efficient resource use   | Requires tuning and monitoring     |
| Better agent workflow performance | Slightly higher system complexity |

For most agent-driven automation workloads, the benefits outweigh the added complexity once the system is tuned.

## Summary

The dual-model pattern is a practical way to get better overall performance and specialization from local LLMs without needing enterprise-grade hardware. Combined with TurboQuant optimization and good agent orchestration, it enables capable, reliable local AI systems.

Next steps: Review `model-optimization.md` for compression techniques and `ARCHITECTURE.md` for how this fits into the broader system.
