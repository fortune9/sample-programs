#!/usr/bin/env python3
"""
Script to call AWS Bedrock with Claude Haiku
"""

import boto3
import json
import argparse

def list_available_models(region_name='us-east-1'):
    """List all available foundation models in Bedrock"""
    bedrock = boto3.client(
        service_name='bedrock',
        region_name=region_name
    )
    try:
        response = bedrock.list_foundation_models()
        print("\nAvailable Claude models:")
        for model in response['modelSummaries']:
            if 'claude' in model['modelId'].lower():
                print(f"  - {model['modelId']}")
        print()
    except Exception as e:
        print(f"Error listing models: {e}\n")

def call_claude_haiku(prompt, max_tokens=1024, temperature=1.0, region_name='us-east-1'):
    """
    Call Claude Haiku via AWS Bedrock

    Args:
        prompt: The user prompt to send to Claude
        max_tokens: Maximum tokens in the response
        temperature: Temperature for response generation (0-1)
        region_name: AWS region name

    Returns:
        The response from Claude
    """
    # Initialize Bedrock client
    bedrock = boto3.client(
        service_name='bedrock-runtime',
        region_name=region_name
    )

    # Try multiple possible model IDs for Claude Haiku
    # Claude 3.5 Haiku is the latest Haiku model available
    possible_model_ids = [
        'us.anthropic.claude-3-5-haiku-20241022-v1:0',  # Cross-region inference
        'anthropic.claude-3-5-haiku-20241022-v1:0',     # Standard
    ]

    model_id = possible_model_ids[0]  # Default to first option

    # Prepare the request body in the Messages API format
    request_body = {
        "anthropic_version": "bedrock-2023-05-31",
        "max_tokens": max_tokens,
        "temperature": temperature,
        "messages": [
            {
                "role": "user",
                "content": prompt
            }
        ]
    }

    # Try each model ID until one works
    last_error = None
    for model_id in possible_model_ids:
        try:
            print(f"Trying model ID: {model_id}")
            # Invoke the model
            response = bedrock.invoke_model(
                modelId=model_id,
                body=json.dumps(request_body)
            )

            # Parse the response
            response_body = json.loads(response['body'].read())

            # Extract the text content
            return response_body['content'][0]['text']

        except Exception as e:
            last_error = e
            print(f"  Failed: {str(e)}")
            continue

    # If all model IDs failed, return the last error
    return f"Error calling Bedrock: {str(last_error)}\n\nPlease run with --list-models to see available models."


def main():
    """Main function to demonstrate usage"""
    import sys
    import os

    # Parse command-line arguments
    parser = argparse.ArgumentParser(description='Call AWS Bedrock with Claude Haiku')
    parser.add_argument('--region', '-r', 
                        default='us-east-1',
                        help='AWS region name (default: us-east-1)')
    parser.add_argument('--list-models', 
                        action='store_true',
                        help='List all available Claude models')
    parser.add_argument('--prompt', '-p',
                        default='What is the capital of France? Please answer in one sentence.',
                        help='Prompt to send to Claude (default: "What is the capital of France? Please answer in one sentence.")')
    args = parser.parse_args()
    
    region_name = args.region

    # Print a messege to set environment variable AWS_PROFILE,
    # otherwise this program will fail, complaining about not being
    # able to connect to endpoints
    # check if AWS_PROFILE is set
    if 'AWS_PROFILE' not in os.environ:
        print("Please set the AWS_PROFILE environment variable to your AWS credentials profile.")
        print("Example: export AWS_PROFILE=your-profile-name\n")
        return

    print("Using AWS_PROFILE:", os.environ['AWS_PROFILE'])
    print(f"Using region: {region_name}\n")

    # Check if user wants to list models
    if args.list_models:
        list_available_models(region_name)
        return

    # Example prompt
    prompt = args.prompt

    print("Calling Claude Haiku via AWS Bedrock...")
    print(f"Prompt: {prompt}\n")

    # Call the model
    response = call_claude_haiku(prompt, region_name=region_name)

    print("\nResponse:")
    print(response)
    print("\nTip: Run with --list-models to see all available Claude models in your region")


if __name__ == "__main__":
    main()
