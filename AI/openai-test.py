#!/bin/env python3

from openai import OpenAI
client = OpenAI()

print("Sending request to OpenAI...")

response = client.responses.create(
    model="gpt-5-nano",
    input="Write a one-sentence bedtime story about a unicorn."
)

print("Response from OpenAI:")
print(response.output_text)

