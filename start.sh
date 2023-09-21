#!/bin/bash



export DB_USER=postgres
export DB_PASSWORD=postgres
export DB_HOST=localhost
export DB_PORT=5432
export DB_NAME=postgres
export DB_USE_TLS=false



trap shutdown INT

function shutdown() {
  pkill -SIGINT postgresql-prometheus-adapter
}

adapter_send_timeout=${adapter_send_timeout:-'30s'}
web_listen_address="${web_listen_address:-':9201'}"
web_telemetry_path="${web_telemetry_path:-'/metrics'}"
log_level="${log_level:-'info'}"
log_format="${log_format:-'logfmt'}"
pg_partition="${pg_partition:-'hourly'}"
pg_commit_secs=${pg_commit_secs:-30}
pg_commit_rows=${pg_commit_rows:-20000}
pg_threads="${pg_threads:-1}"
parser_threads="${parser_threads:-5}"

echo /postgresql-prometheus-adapter \
  --adapter-send-timeout=${adapter_send_timeout} \
  --web-listen-address=${web_listen_address} \
  --web-telemetry-path=${web_telemetry_path} \
  --log.level=${log_level} \
  --log.format=${log_format} \
  --pg-partition=${pg_partition} \
  --pg-commit-secs=${pg_commit_secs} \
  --pg-commit-rows=${pg_commit_rows} \
  --pg-threads=${pg_threads} \
  --parser-threads=${parser_threads}

/postgresql-prometheus-adapter \
  --adapter-send-timeout=${adapter_send_timeout} \
  --web-listen-address=${web_listen_address} \
  --web-telemetry-path=${web_telemetry_path} \
  --log.level=${log_level} \
  --log.format=${log_format} \
  --pg-partition=${pg_partition} \
  --pg-commit-secs=${pg_commit_secs} \
  --pg-commit-rows=${pg_commit_rows} \
  --pg-threads=${pg_threads} \
  --parser-threads=${parser_threads}

