#!/usr/bin/env bash

# Validate environment variables

validate_domain() {
  if [[ "$1" == "localhost" ]]; then
    return
  fi

  if ! [[ "$1" =~ ^([a-zA-Z0-9][a-zA-Z0-9-]{0,61}[a-zA-Z0-9]\.)+[a-zA-Z]{2,}$ ]]; then
    echo "ERROR: '$1' is not a valid domain name"
    exit 1
  fi
}

validate_email_address() {
  if ! [[ "$1" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
      echo "ERROR: '$1' is not a valid email address"
      exit 1
    fi
}

[[ "$MAIL_SMTP_SERVER" == "" ]] || validate_domain "$MAIL_SMTP_SERVER"
[[ "$MAIL_SMTP_DOMAIN" == "" ]] || validate_domain "$MAIL_SMTP_DOMAIN"
[[ "$MAIL_SMTP_USERNAME" == "" ]] || validate_email_address "$MAIL_SMTP_USERNAME"
[[ "$MAIL_SMTP_DEFAULT_FROM_ADDRESS" == "" ]] || validate_email_address "$MAIL_SMTP_DEFAULT_FROM_ADDRESS"
[[ "$MAIL_SMTP_DEFAULT_REPLY_ADDRESS" == "" ]] || validate_email_address "$MAIL_SMTP_DEFAULT_REPLY_ADDRESS"
