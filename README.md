# Docker image for ruff checker

[ruff](https://pypi.org/project/ruff/) is a Python linter and code formatter.

## Usage

    $ docker run --rm -v /path/to/python/code:/code eeacms/ruff check

or

    $ docker run --rm -v /path/to/python/code:/code eeacms/ruff format


## Running in jenkins, including pull requests:

* GIT_NAME, GIT_SRC  - must be given
* GIT_BRANCH - defaults to master
* GIT_CHANGE_ID - can be empty or pull request id


    $ docker run -i --rm -e GIT_SRC="https://github.com/eea/$GIT_NAME.git" -e GIT_NAME="$GIT_NAME" -e GIT_BRANCH="$BRANCH_NAME" -e GIT_CHANGE_ID="$CHANGE_ID" eeacms/ruff check
    $ docker run -i --rm -e GIT_SRC="https://github.com/eea/$GIT_NAME.git" -e GIT_NAME="$GIT_NAME" -e GIT_BRANCH="$BRANCH_NAME" -e GIT_CHANGE_ID="$CHANGE_ID" eeacms/ruff format
