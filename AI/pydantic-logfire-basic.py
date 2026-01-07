#!/bin/env python3

"""
A basic example of integrating Logfire with Pydantic Evals.

When first run, it will ask for project and credential details to set
up Logfire, creating a file .logfire/logfire_credentials.json in
current folder.

Then you can see logs of evaluation runs in your Logfire web UI dashboard.
"""

import logfire

from pydantic_evals import Case, Dataset

# Configure Logfire
logfire.configure(
)


# Your evaluation code
def my_task(inputs: str) -> str:
    return f'result for {inputs}'


dataset = Dataset(cases=[Case(name='test', inputs='example')])
report = dataset.evaluate_sync(my_task)


