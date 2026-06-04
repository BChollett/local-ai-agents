# Agent Orchestration

This document describes how autonomous agents are coordinated in this system, with a focus on integrating multiple language models and tools into reliable workflows.

## Overview

Effective agent systems need more than just a powerful language model. They require coordination logic that can:

- Break down complex tasks
- Route work to the most appropriate model or tool
- Maintain memory and context across steps
- Handle errors and retries gracefully
- Improve over time through experience

The orchestration layer serves as the central coordinator that makes these capabilities possible.

## Core Technologies

### Hermes Agent Framework

Hermes provides a strong foundation for self-improving agents. Key capabilities used here include:

- Built-in learning loops (agents can create and refine skills from experience)
- Persistent memory across sessions
- Support for tool registration and dynamic tool calling
- Good integration with local model endpoints

### OpenClaw

OpenClaw complements Hermes by providing a flexible runtime for agent execution and tool integration across different channels and environments.

### Custom Orchestration Layer

On top of these frameworks, custom coordination logic handles:
- Intelligent routing between the primary and secondary models
- Task decomposition and step planning
- Coordination of tool results back into the reasoning flow
- Fallback and error recovery strategies

This combination allows the system to leverage the strengths of both frameworks while adding application-specific behavior.

## Model Routing Strategy

A key part of orchestration is deciding which model should handle a given step:

- **Primary model** (stronger reasoning): Used for complex planning, architecture decisions, debugging difficult problems, and long reasoning chains.
- **Secondary model** (faster / lighter): Used for tool calling, simple decisions, status checks, and intermediate steps that don't require maximum capability.

This routing improves both quality and responsiveness. The orchestration layer makes these decisions dynamically based on task type, current load, and historical performance.

## Memory and Skill Management

Reliable agents need good memory:

- **Short-term memory**: Current conversation context and recent tool results
- **Long-term memory / Skills**: Learned procedures and successful patterns that can be reused

The Hermes framework's self-improvement mechanisms allow agents to create new skills when they encounter recurring task patterns. Over time, this reduces reliance on raw model reasoning for common operations.

## Tool Integration

Tools extend what agents can do beyond text generation:

- Tools are registered with clear input/output schemas
- The orchestration layer handles tool selection and parameter generation
- Results from tool execution are fed back into the agent's context
- Error handling and retries are managed at the orchestration level

Good tool design is often more important than model size for real-world reliability.

## Workflow Example

A typical orchestrated workflow might look like this:

1. User request or scheduled trigger arrives
2. Orchestrator decomposes the task
3. Primary model creates a high-level plan
4. Secondary model executes individual steps and tool calls
5. Tool results are collected and validated
6. Primary model reviews results and decides next steps or completion
7. Final output is generated and (if applicable) actions are taken

This hybrid approach combines deep reasoning with efficient execution.

## Benefits of This Approach

- Better performance through model specialization
- Improved reliability via structured error handling and retries
- Faster response times for simpler sub-tasks
- Ability to improve over time through skill creation
- Clear separation between reasoning, execution, and tool use

## Current Limitations

- Routing logic still requires tuning and occasional manual adjustment
- Self-improvement is powerful but can be inconsistent early on
- Complex multi-step workflows can still fail in unexpected ways
- Requires good observability to debug issues effectively

## Future Improvements

- More sophisticated routing based on task classification and historical success rates
- Stronger long-term memory consolidation
- Better evaluation frameworks for agent workflows
- Expanded library of robust, reusable tools

See `ARCHITECTURE.md` for the overall system view and `dual-llm-deployment.md` for details on the model setup that makes this orchestration effective.
