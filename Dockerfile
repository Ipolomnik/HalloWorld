FROM nginx:1.27-alpine

COPY ./ /usr/share/nginx/html/

HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD wget -qO- http://127.0.0.1/ || exit 1

EXPOSE 80


