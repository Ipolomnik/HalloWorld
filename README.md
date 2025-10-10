# Hallo World — контейнер со статической страницей

Простая страница "Hello, World" разворачивается в контейнере Nginx.

## Быстрый старт локально (Docker Compose)

```bash
cd hallo_world
docker compose up --build -d
```

Откройте: `http://localhost:8081`

Остановить и удалить:
```bash
docker compose down
```

## Запуск через Docker (без compose)

```bash
cd hallo_world
docker build -t hallo-world:latest .
docker run -d --name hallo-world -p 8081:80 hallo-world:latest
```

## Базовая настройка сервера (Linux)

- Требования: установлен Docker и Docker Compose v2
- Открыть порт в фаерволе (пример для UFW):
  ```bash
  sudo ufw allow 8081/tcp
  ```
- Сервис в автозапуске (systemd unit пример):
  ```bash
  # Создать сервисный файл
  sudo tee /etc/systemd/system/hallo-world.service >/dev/null << 'SERVICE'
  [Unit]
  Description=Hallo World container
  After=network.target docker.service
  Requires=docker.service

  [Service]
  Restart=always
  ExecStart=/usr/bin/docker run --rm --name hallo-world -p 8081:80 hallo-world:latest
  ExecStop=/usr/bin/docker stop hallo-world

  [Install]
  WantedBy=multi-user.target
  SERVICE

  sudo systemctl daemon-reload
  sudo systemctl enable --now hallo-world
  ```
- Реверс‑прокси (опционально): установите Nginx/Traefik/Caddy и проксируйте :8081 на домен с HTTPS (через certbot или ACME в Caddy/Traefik).

## Обновление контейнера

```bash
cd hallo_world
# если проект в Git
# git pull

docker compose build --no-cache
docker compose up -d
```
