# Model Optimization

This document covers the key optimization techniques used to run capable large language models locally with good efficiency and stability.

## Why Optimization Matters

Running large models locally (especially multiple models simultaneously) requires careful memory and compute management. Without optimization, VRAM usage quickly becomes a bottleneck, limiting context length, batch size, or the ability to run multiple models at once.

The techniques described here focus on practical improvements that allow stable, long-running inference on consumer hardware.

## TurboQuant

**TurboQuant** is a quantization and KV cache compression technique that significantly reduces memory footprint while preserving model quality.

### Key Benefits
- Reduced KV cache size (often 2x–4x compression depending on settings)
- Lower VRAM usage for the same context length
- Better support for expert offloading in Mixture-of-Experts (MoE) models
- Maintains acceptable generation quality for most use cases

### How It's Used

TurboQuant is applied during model loading in llama.cpp. It works particularly well with MoE architectures (such as certain Qwen models) by allowing more efficient expert loading and caching.

Recommended starting point:
- Enable TurboQuant KV cache compression
- Combine with appropriate quantization level (Q4_K_M or Q5_K_M are common sweet spots)
- Tune context length based on available VRAM after compression

## KV Cache Compression

The KV cache is one of the largest memory consumers during inference, especially with long contexts. Compressing it allows much longer contexts or running additional models within the same VRAM budget.

### Practical Impact
- Enables longer context windows without running out of memory
- Improves tokens-per-second in memory-bound scenarios
- Critical when running two models simultaneously

## Expert Offloading (MoE Models)

Mixture-of-Experts models contain many specialized "experts." Not all experts are active for every token. Expert offloading moves less frequently used experts to CPU or system RAM, freeing GPU VRAM for active computation.

### Benefits in This Setup
- Allows running larger MoE models on limited VRAM
- Works synergistically with TurboQuant
- Enables the dual-model pattern by keeping total GPU memory usage manageable

## VRAM Management Strategies

Some practical techniques used to maintain stable dual-model operation:

- Careful port separation and resource allocation between the two servers
- Monitoring actual VRAM usage during typical workloads
- Adjusting context length and batch size per model based on its role (primary vs secondary)
- Using quantization levels appropriate for each model's task (heavier quantization on the secondary model if acceptable)

## Observed Results

With the tested hardware (RTX 5060 Ti 16GB):

- Stable dual-model operation is achievable with ~13–15 GB VRAM usage under normal loads
- TurboQuant + expert offloading provides meaningful headroom compared to unoptimized loading
- Long-running sessions remain stable without frequent memory-related crashes or slowdowns

Exact numbers vary depending on model size, quantization, context length, and workload.

## Trade-offs

- Some compression techniques can slightly reduce output quality (usually minor at Q4_K_M / Q5_K_M levels)
- Expert offloading can introduce small latency penalties when experts need to be swapped in
- Requires more tuning and monitoring than running a single unoptimized model

These trade-offs are generally acceptable for gaining the ability to run capable local models reliably.

## Recommendations

Start with:
1. TurboQuant enabled + reasonable quantization
2. Measure baseline VRAM usage
3. Gradually increase context length or add the second model
4. Monitor stability over longer sessions

See `SETUP.md` for launch configuration and `dual-llm-deployment.md` for running two models together.
