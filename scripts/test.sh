#!/usr/bin/env bash

# Check if WSL:
if [[ "$(uname -s)" == *[Ll]inux* ]] 2>/dev/null; then
  readonly WSL=1
  echo "WSL detected"
else
  readonly WSL=0
fi
