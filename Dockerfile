FROM ghcr.io/danny-avila/librechat:latest

USER root

# Copia sua configuração personalizada
COPY librechat.yaml /app/librechat.yaml

# Corrige o CVE-2026-54466 instantaneamente sem reindexar o projeto inteiro (leva ~2s):
RUN npm install -g npm@latest && \
    find /app -name "websocket-driver" -type d -exec sh -c 'cd "{}" && npm install websocket-driver@0.7.5 --no-save --no-package-lock 2>/dev/null || true' \; || true

# Permissões cirúrgicas nos diretórios de escrita do LibreChat
RUN mkdir -p /app/api/logs /app/uploads /app/client/public/images && \
    chown -R 10001:10001 /app/api/logs /app/uploads /app/client/public/images /app/librechat.yaml

ENV HOST=0.0.0.0
ENV PORT=3080
EXPOSE 3080

USER 10001

CMD ["npm", "run", "backend"]
