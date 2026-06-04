# local-ai-agents

Local-first autonomous AI systems and agent orchestration running reliably on consumer hardware.

I build and run production-oriented local LLM infrastructure and autonomous agent frameworks that handle real automation workloads. The focus is on reliable self-hosted inference, intelligent orchestration across multiple models, custom tool integration, and agent-driven workflows for productivity and platform automation.

## Why This Exists

Most powerful AI capabilities today are locked behind cloud APIs. I wanted a fully local, self-hosted stack that is:
- Reliable enough for daily productive use
- Capable of running multiple specialized models simultaneously
- Able to orchestrate complex, multi-step tasks through autonomous agents
- Practical for building real automation systems (e.g., content workflows, tracking, and analytics)

This repo documents the architecture, optimization techniques, and orchestration patterns I use to make that possible on consumer hardware.

## Key Highlights

- **Dual-model local inference** — Run a primary high-capability model alongside a secondary model optimized for tool use and lighter tasks on the same machine with stable VRAM usage.
- **TurboQuant optimization** — KV cache compression and expert offloading techniques that significantly reduce memory footprint while maintaining quality (especially effective with MoE models).
- **Autonomous agent orchestration** — Integration of Hermes Agent and OpenClaw frameworks with custom coordination patterns for task delegation, memory management, and self-improving workflows.
- **Real automation platform** — Technical leadership on an AI-agent-driven system for social media link posting, click tracking, and engagement analytics. Agents handle scheduling, content distribution, performance measurement, and iterative improvement.
- **Practical tooling** — Custom tools, reliable execution patterns, and monitoring approaches that make local agents dependable for ongoing work.

## Tech Stack

- **Inference**: llama.cpp with TurboQuant (KV cache compression + expert offloading)
- **Model Serving**: Dual always-on servers (primary model + secondary model on separate ports)
- **Agent Frameworks**: Hermes Agent + OpenClaw with custom orchestration layer
- **Tooling & Automation**: Custom tool definitions, memory systems, task scheduling, and result synthesis
- **Platform Layer**: Agent hierarchy for content distribution, engagement tracking, and analytics workflows
- **Hardware**: AMD Ryzen 7 7700X + RTX 5060 Ti 16GB + 32GB RAM (fully local, no cloud dependency)

## Hardware Requirements

Tested configuration:
- CPU: AMD Ryzen 7 7700X (8-core)
- GPU: NVIDIA RTX 5060 Ti 16GB
- RAM: 32GB
- OS: Windows 11 Pro

The setup is designed to run stably with both models loaded simultaneously while leaving headroom for agent orchestration and tooling.

## Quick Start

> **Note**: Exact model choices and ports are configured in the `examples/dual-llm-setup/` directory.

```bash
# 1. Clone the repo
git clone https://github.com/BChollett/local-ai-agents.git
cd local-ai-agents

# 2. Install llama.cpp with TurboQuant support (see scripts/setup-llama-cpp.sh)
./scripts/setup-llama-cpp.sh

# 3. Launch dual-model setup
./scripts/start-dual-models.sh
```

See `SETUP.md` for full installation, model download recommendations, and port configuration.

## Project Structure

```
local-ai-agents/
├── README.md
├── ARCHITECTURE.md
├── SETUP.md
├── LICENSE
├── .gitignore
├── docs/
│   ├── hardware-specs.md
│   ├── model-optimization.md
│   ├── dual-llm-deployment.md
│   ├── agent-orchestration.md
│   └── automation-examples.md
├── examples/
│   ├── dual-llm-setup/
│   ├── agent-tools/
│   └── orchestration-patterns/
├── scripts/
│   └── start-dual-models.sh
└── assets/
```

## Architecture Overview

The system is built in layers:

1. **Inference Layer** — Optimized local LLM serving with TurboQuant for efficient memory use and dual-model deployment.
2. **Orchestration Layer** — Hermes + OpenClaw integration with custom coordination logic that routes tasks between models, manages memory, and handles self-improvement loops.
3. **Tool & Automation Layer** — Extensible tools for real-world actions (scheduling, data retrieval, posting, analytics collection).
4. **Application Layer** — Agent-driven platform for social link management, automated posting, performance tracking, and engagement analytics.

Full details and diagrams are in `ARCHITECTURE.md`.

## Use Cases & Examples

- **Autonomous workflow orchestration** — Multi-step tasks that require reasoning, tool use, memory recall, and result synthesis.
- **Platform automation** — AI agents that manage content distribution across social channels, track performance metrics, and feed insights back into future decisions.
- **Local productivity systems** — Reliable daily drivers for coding assistance, research, planning, and repetitive automation without sending data to external services.

See `docs/automation-examples.md` and the `examples/` directory for concrete patterns.

## Performance & Optimization Notes

Key techniques used to run capable models locally with good stability:

- TurboQuant KV cache compression and expert offloading for MoE architectures
- Careful port separation and resource allocation between primary and secondary models
- Persistent memory and skill systems within the agent framework
- Benchmarking and monitoring scripts to track tokens/sec, VRAM usage, and thermal behavior over long sessions

Detailed metrics and configuration recommendations live in `docs/model-optimization.md` and `docs/dual-llm-deployment.md`.

## Limitations (Being Honest)

- This is a local, single-machine setup — not a distributed cluster.
- Model quality and speed are constrained by available VRAM and the specific models chosen.
- Agent reliability improves with good tool design and memory management, but complex multi-agent systems still require careful orchestration.
- Some advanced self-improvement features are still experimental in the frameworks used.

## Future Direction

- Expand the set of reliable, reusable agent tools
- Improve long-term memory and skill persistence across sessions
- Add more robust monitoring, logging, and self-correction mechanisms
- Continue evolving the agent-driven platform for content and analytics automation
- Explore tighter integration between the orchestration layer and external services where appropriate

## License

MIT License — feel free to use any patterns or scripts that are useful to you.

---

**Built and maintained by Brandon Chollett**  
Software engineer focused on local AI infrastructure and autonomous agent systems.

---
