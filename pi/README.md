# WeatherStar on a Raspberry Pi (North Myrtle Beach, SC)

Defaults to North Myrtle Beach, SC. Weather data comes straight from api.weather.gov in the browser,
so the Pi only serves ~850 KB of static files (Python's built-in server, ~10 MB RAM).

1. Raspberry Pi OS (Lite is NOT enough — you need the desktop + Chromium).
2. `git clone <this repo> && cd ws3kp && sudo sh pi/install.sh && sudo reboot`

Tips for very slow Pis: in Chromium settings keep only the displays you want (uncheck radar-heavy ones),
use 1280x720 output (`raspi-config` → Display), and set GPU memory to 128.

Rebuild `pi/www` after code changes on a PC: `npm ci && npm run build && rm -rf pi/www && cp -r dist pi/www`.
