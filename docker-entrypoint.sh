#!/bin/sh
set -e

CMD="$1"
RUFF_MODE="$2"

if [ "$CMD" = "format" ] || [ "$CMD" = "check" ]; then
  RUFF_MODE="$CMD"
  CMD="ruff"
fi

if [[ ${CMD:0:4} = "http" ]]; then
  GIT_SRC=$1
  CMD="ruff"
fi

if [[ ${CMD:0:3} = "git" ]]; then
  GIT_SRC=$1
  CMD="ruff"
fi

if [ ! -z "$GIT_SRC" ]; then
  cd /code
  git clone "$GIT_SRC"

  if [ ! -z "$GIT_NAME" ]; then
    if [ -z "$GIT_BRANCH" ]; then
      GIT_BRANCH="master"
    fi

    cd "$GIT_NAME"

    if [ ! -z "$GIT_CHANGE_ID" ]; then
      GIT_BRANCH="PR-${GIT_CHANGE_ID}"
      git fetch origin pull/"$GIT_CHANGE_ID"/head:"$GIT_BRANCH"
    fi

    git checkout "$GIT_BRANCH"
    cd /code
  fi
fi

if [ -z "$RUFF_MODE" ]; then
  RUFF_MODE="check"
fi

if [ "$CMD" = "ruff" ]; then
  cd /code/$GIT_NAME
  case "$RUFF_MODE" in
    "check")
      ruff check --fix --exclude Extensions,extensions,skins --config /ruff.toml
      ;;
    "format")
      ruff format --exclude Extensions,extensions,skins --config /ruff.toml
      ;;
    *)
      echo "Unknown mode: $RUFF_MODE (use 'check' or 'format')"
      exit 1
      ;;
  esac
else
  exec "$@"
fi
