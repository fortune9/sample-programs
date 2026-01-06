#!/bin/env python3

from openai import OpenAI
client = OpenAI()

print("Sending request to GPT-5 with image input...")

tools = [
    {
        "type": "function",
        "name": "get_weather",
        "description": "Get current temperature for a given location.",
        "parameters": {
            "type": "object",
            "properties": {
                "location": {
                    "type": "string",
                    "description": "City and country e.g. Bogotá, Colombia",
                }
            },
            "required": ["location"],
            "additionalProperties": False,
        },
        "strict": True,
    },
]

response = client.responses.create(
    model="gpt-5",
    input=[
        {"role": "user", "content": "What is the weather like in Paris today?"},
    ],
    tools=tools,
)

print("Response from GPT-5:")
print(response.output[0].to_json())

print("Response metadata:")
print(response.metadata)
print("Response usage:")
print(response.usage)

print("Done.")

