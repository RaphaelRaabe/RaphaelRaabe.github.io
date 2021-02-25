#!/usr/bin/env bash

RUN_SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source "$RUN_SCRIPT_PATH/scripts/01_pxSuffixGenerator.sh"
source "$RUN_SCRIPT_PATH/scripts/02_thumbnailGenerator.sh"
source "$RUN_SCRIPT_PATH/scripts/03_paintingsCSVGenerator.sh"
