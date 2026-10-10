#!/bin/sh
# Launch Chromium fullscreen on the WeatherStar. Flags trim memory/CPU for low-end Pis.
BROWSER="$(command -v chromium-browser || command -v chromium)"
sleep 5
# kiosk=true plays immediately; North Myrtle Beach is also the built-in default
exec "$BROWSER" --kiosk --noerrdialogs --disable-infobars --incognito \
  --no-first-run --disable-session-crashed-bubble --check-for-update-interval=31536000 \
  --disable-features=Translate,MediaRouter --disable-sync --disable-extensions \
  --disable-background-networking --disable-component-update \
  --disable-smooth-scrolling --disable-gpu-vsync --renderer-process-limit=1 \
  --js-flags="--max-old-space-size=96" \
  "http://127.0.0.1:8083/?settings-kiosk-checkbox=true"
