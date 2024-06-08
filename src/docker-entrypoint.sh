#!/usr/bin/env bash

set -eo pipefail

echo "Executing startup scripts..."
[ -d /docker-entrypoint.d/ ] && [ "$(ls -1 /docker-entrypoint.d/*.sh 2> /dev/null)" ] && {
  chmod +x /docker-entrypoint.d/*.sh
  run-parts --report --regex='\.sh' /docker-entrypoint.d
}

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- apache2-foreground "$@"
fi

exec "$@"
