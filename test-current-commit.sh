#!/bin/sh

echo | "$(dirname "$0")/.githooks/pre-push" localhost https://localhost
