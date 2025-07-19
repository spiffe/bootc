#!/bin/bash

REGISTRY=localhost
REPO=spire
BASE=""
RUNTIME=auto
PREFIX=""

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -v|--verbose)
      VERBOSE=1
      shift # Consume the option
      ;;
    --base)
      if [[ -n "$2" && "$2" != -* ]]; then
        BASE="$2"
        shift 2
      else
        echo "Error: you must specify a base image"
        exit 1
      fi
      ;;
    --runtime)
      if [[ -n "$2" && "$2" != -* ]]; then
        RUNTIME="$2"
        shift 2
      else
        echo "Error: you must specify a runtime"
        exit 1
      fi
      ;;
    --registry)
      if [[ -n "$2" && "$2" != -* ]]; then
        REGISTRY="$2"
        shift 2
      else
        echo "Error: you must specify a registry"
        exit 1
      fi
      ;;
    --repo)
      if [[ -n "$2" && "$2" != -* ]]; then
        REPO="$2"
        shift 2
      else
        echo "Error: you must specify a repo"
        exit 1
      fi
      ;;
    --prefix)
      if [[ -n "$2" && "$2" != -* ]]; then
        PREFIX="$2"
        shift 2
      else
        echo "Error: you must specify a prefix"
        exit 1
      fi
      ;;
    -h|--help)
      echo "Usage: $0 --base <baseimage> [--runtime <podman|docker>]"
      exit 0
      ;;
    *)
      echo "Unknown option"
      exit 1
      ;;
  esac
done

if [[ "$BASE" == "" ]]; then
  echo "Error: You must specify a base image"
  exit 1
fi

if [[ "$RUNTIME" == "auto" ]]; then
  if command -v podman >/dev/null 2>&1; then
    RUNTIME=podman
  else
    RUNTIME=docker
  fi
fi

echo "Runtime = $RUNTIME"
echo "Base image = $BASE"
echo "Registry = $REGISTRY"
echo "Repo = $REPO"
echo "Tag Prefix = $PREFIX"

if [[ "$PREFIX" != "" ]]; then
  PREFIX="-"
fi

"$RUNTIME" build -t "$REGISTRY/$REPO:$PREFIX"spire-agent spire-agent/ --build-arg=BASE=$BASE

"$RUNTIME" build -t "$REGISTRY/$REPO:$PREFIX"spire-ha-agent spire-ha-agent/ --build-arg=BASE="$REGISTRY/$REPO:$PREFIX"spire-agent

"$RUNTIME" build -t "$REGISTRY/$REPO:$PREFIX"spire-server spire-server/ --build-arg=BASE="$REGISTRY/$REPO:$PREFIX"spire-agent
"$RUNTIME" build -t "$REGISTRY/$REPO:$PREFIX"spire-ha-server-intermediate spire-server/ --build-arg=BASE="$REGISTRY/$REPO:$PREFIX"spire-ha-agent

"$RUNTIME" build -t "$REGISTRY/$REPO:$PREFIX"spire-ha-server spire-ha-server/ --build-arg=BASE="$REGISTRY/$REPO:$PREFIX"spire-ha-server-intermediate
