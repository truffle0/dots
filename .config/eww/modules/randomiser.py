#!/bin/env python
from time import sleep
import json
import random

if __name__ == "__main__":
    with open("/home/truffle/Downloads/warandpeace.txt") as f:
        words = f.read().split()
    
    while True:
        output = {"word": random.choice(words)}
        print(json.dumps(output), flush=True)
        sleep(10)