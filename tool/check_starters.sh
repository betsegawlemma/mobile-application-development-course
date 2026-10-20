#!/usr/bin/env bash
# Fails when a lab starter no longer leaves its tasks to the student.
# See tool/check_starters.py for the rules.
set -euo pipefail
cd "$(dirname "$0")/.."
python3 tool/check_starters.py
