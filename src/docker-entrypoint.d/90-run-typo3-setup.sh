#!/usr/bin/env bash


DONE_FLAG_FILE="${WEB_ROOT}"/typo3conf/.initialized

if [ "$TYPO3_AUTO_SETUP_ENABLE" == "true" ] && [ ! -f "$DONE_FLAG_FILE" ]; then

  # Run automated Typo3 setup using the Typo3 CLI tool
  echo "Running automated Typo3 setup..."

  # Verify typo3 binary
  typo3 --version || (echo "ERROR: Setup failed"; exit 1)

  TYPO3_SERVER_TYPE="apache" \
  typo3 setup --no-interaction && \
  (echo "Setup finished"
  touch "$DONE_FLAG_FILE") || \
  (echo "ERROR: Setup failed"
  exit 1)

elif [ ! -f "$DONE_FLAG_FILE" ]; then

  # Mark as first install if not initialized yet
  touch "${WEB_ROOT}"/FIRST_INSTALL && \
  touch "$DONE_FLAG_FILE"

else
    typo3 --version || (echo "ERROR: Typo3 installation appears to be corrupted "; exit 1)
fi