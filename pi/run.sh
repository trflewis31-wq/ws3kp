#!/bin/sh
# Run the WeatherStar straight from the files: no server, no install.
DIR="$(cd "$(dirname "$0")" && pwd)"
BROWSER="$(command -v chromium-browser || command -v chromium)"
exec "$BROWSER" --kiosk --noerrdialogs --disable-infobars --no-first-run \
  --disable-session-crashed-bubble --disable-extensions --disable-sync \
  --disable-background-networking --renderer-process-limit=1 \
  --js-flags="--max-old-space-size=96" \
  "file://$DIR/www/index.html?settings-kiosk-checkbox=true"
