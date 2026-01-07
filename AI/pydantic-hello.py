#!/bin/env python3

from pydantic_ai import Agent

defaultModel="google-gla:gemini-2.5-flash"

agent = Agent(  
    model=defaultModel,
    instructions='Be concise, reply with one sentence.',  
)

result = agent.run_sync('Where does "hello world" come from?')  
print(result.output)
"""
The first known use of "hello, world" was in a 1974 textbook about the C programming language.
"""

