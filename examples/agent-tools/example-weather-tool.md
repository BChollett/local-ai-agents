# Example Tool: Weather Information

This is a simple example of a tool that an agent can use to retrieve weather data.

## Tool Definition

```json
{
  "name": "get_weather",
  "description": "Get current weather information for a given location.",
  "parameters": {
    "type": "object",
    "properties": {
      "location": {
        "type": "string",
        "description": "City and state, e.g. Omaha, Nebraska"
      },
      "units": {
        "type": "string",
        "enum": ["celsius", "fahrenheit"],
        "description": "Temperature units"
      }
    },
    "required": ["location"]
  }
}
```

## Usage Notes

- The agent should call this tool when the user asks about weather or needs location-specific information.
- Always validate that the location is reasonable before calling.
- Return results in a structured format the agent can easily parse.

## Example Agent Prompt

> If the user asks about the weather, use the get_weather tool with the location they mentioned.
