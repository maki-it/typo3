#!/usr/bin/env bash

# Adjust permissions
# One path above document root (../) needs to be writable (new directories will be created during updates).
cd "${WEB_ROOT}" || exit 1
chown -R www-data:www-data "${WEB_ROOT}"/..
