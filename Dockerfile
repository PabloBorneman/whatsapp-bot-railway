FROM node:18-bullseye

# Instala solo lo esencial para Puppeteer + ffmpeg
RUN apt-get update && \
    apt-get install -y wget ca-certificates ffmpeg \
    fonts-liberation libnss3 libatk1.0-0 libatk-bridge2.0-0 \
    libcairo2 libpango-1.0-0 libx11-xcb1 libxcomposite1 \
    libxdamage1 libxrandr2 libgbm1 libasound2 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .

CMD ["node", "index.js"]
