#!/usr/bin/env bash

# Run automated Typo3 setup using the Typo3 CLI tool

if [ "$TYPO3_AUTO_SETUP_ENABLE" == "true" ]; then
  TYPO3_SERVER_TYPE="apache"

fi