#!/usr/bin/env python3

# need to start the ollama server first:
# $ ollama serve

from pydantic import BaseModel

from pydantic_ai import Agent
from pydantic_ai.models.openai import OpenAIChatModel
from pydantic_ai.providers.ollama import OllamaProvider


class CityLocation(BaseModel):
    city: str
    country: str


# Manually specify the Ollama model and provider
ollama_model = OpenAIChatModel(
    model_name='qwen3:4b', # don't specify 'ollama:' prefix here
    provider=OllamaProvider(base_url='http://localhost:11434/v1')  
)
agent = Agent(ollama_model, output_type=CityLocation)
#agent = Agent('ollama:qwen3:4b', output_type=CityLocation) # alternative shorthand way

result = agent.run_sync('Where were the olympics held in 2012?')
print(result.output)
#> city='London' country='United Kingdom'
print(result.usage())
#> RunUsage(input_tokens=57, output_tokens=8, requests=1)
