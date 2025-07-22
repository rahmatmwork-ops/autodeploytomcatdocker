#!/bin/bash

WATCH_DIR="/watched"

echo "Watching for changes in $WATCH_DIR..."

while true; do
  inotifywait -r -e close_write,moved_to,create "$WATCH_DIR" |
  while read -r directory events filename; do
    filepath="$directory$filename"

    if [[ "$filename" == *.war ]]; then
      echo "Detected new or modified WAR file: $filename"
      touch "$filepath"

    elif [[ -d "$filepath" && -f "$filepath/pom.xml" ]]; then
      echo "Detected Maven project in $filepath, building WAR..."
      cd "$filepath"
      mvn clean package -DskipTests
      cp target/*.war "$WATCH_DIR/"
    fi
  done
done
