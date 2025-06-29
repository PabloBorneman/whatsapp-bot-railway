# ───────────── Base ─────────────
FROM node:18-bullseye-slim   

# ──────────── System deps ────────────
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ffmpeg \
        ca-certificates \
        fonts-liberation \
        libappindicator3-1 \
        libasound2 \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libcairo2 \
        libcups2 \
        libdbus-1-3 \
        libdrm2 \
        libgbm1 \
        libgtk-3-0 \
        libnspr4 \
        libnss3 \
        libpango-1.0-0 \
        libx11-xcb1 \
        libxcomposite1 \
        libxdamage1 \
        libxrandr2 \
        xdg-utils \
    && rm -rf /var/lib/apt/lists/*   # limpia el caché de apt

# ───────────── App ─────────────
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev        # instala solo prod-deps
COPY . .

# ─────────── Entrypoint ───────────
CMD ["node", "index.js"]
