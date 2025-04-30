#!/bin/bash
# Script to log into the MySQL database console

# Connection details (same as in devcontainer.json)
HOST="127.0.0.1"
USER="vscode"
PASSWORD="password"
DATABASE="mydatabase"

echo "Connecting to MySQL database '$DATABASE' as user '$USER'..."

# Execute the mysql client command
# The -p flag is directly followed by the password (no space)
mysql -h $HOST -u $USER -p$PASSWORD $DATABASE

echo "Exited MySQL console." 