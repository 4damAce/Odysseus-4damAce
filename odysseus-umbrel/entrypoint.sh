#!/bin/sh
set -e

# Generate nginx config with environment variables substituted
envsubst '$ODYSSEUS_PC_HOST,$ODYSSEUS_PC_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec "$@"
