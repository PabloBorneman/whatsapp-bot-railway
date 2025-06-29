FROM node:18-bullseye-slim

# ── system deps ──
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        # ─ libs que necesita Chromium ─
        ca-certificates fonts-liberation libappindicator3-1 libasound2 \
        libatk-bridge2.0-0 libatk1.0-0 libcairo2 libcups2 libdbus-1-3 libdrm2 \
        libgbm1 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libx11-xcb1 \
        libxcomposite1 libxdamage1 libxrandr2 xdg-utils \
        # ─ herramientas de compilación para node-gyp ─
        build-essential python3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev          # si el lock está sano esto debería pasar
COPY . .

CMD ["node", "index.js"]
