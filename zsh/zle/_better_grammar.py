#!python

import asyncio
import os
import sys

import openai
from pydantic import BaseModel

api_key = os.environ.get("OPENAI_API_KEY")

all_args = sys.argv[1:]
input_text = " ".join(all_args)


class CommandGrammarFixer(BaseModel):
    command: str


async def generate() -> str:
    client = openai.AsyncClient(api_key=api_key)
    response = await client.beta.chat.completions.parse(
        model="gpt-4o-2024-08-06",
        messages=[
            {
                "role": "system",
                "content": (
                    "You are an assistant that fixes grammar in shell commands. "
                    "If the input is not a command, respond with an error message. "
                    "If you can make it better, do so."
                ),
            },
            {"role": "user", "content": input_text},
        ],
        response_format=CommandGrammarFixer,
    )
    if (event := response.choices[0].message.parsed) is None:
        print("The input was not recognized as a valid shell command.", file=sys.stderr)
        sys.exit(1)

    return event.command


if __name__ == "__main__":
    print(asyncio.run(generate()))
