#!/bin/env python3

import logfire
from pydantic_ai import Agent, RunContext

logfire.configure()

model_id = 'google-gla:gemini-2.5-flash'
roulette_agent = Agent(  
    model=model_id,
    name='Roulette Wheel Agent',
    deps_type=int,
    output_type=bool,
    system_prompt=(
        'Use the `roulette_wheel` function to see if the '
        'customer has won based on the number they provide.'
    ),
)


@roulette_agent.tool
async def roulette_wheel(ctx: RunContext[int], square: int) -> str:  
    """check if the square is a winner"""
    return 'winner' if square == ctx.deps else 'loser'


# Run the agent
success_number = 18  
print(f'Success number is: {success_number}')
print('---')
print('Testing winning bet: 18')
result = roulette_agent.run_sync('Put my money on square eighteen', deps=success_number)
print(result.output)  
#> True

print('---')
print('Testing losing bet: 5')
result = roulette_agent.run_sync('I bet five is the winner', deps=success_number)
print(result.output)
#> False
