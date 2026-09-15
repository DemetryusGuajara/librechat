FROM ghcr.io/danny-avila/librechat:latest

USER root

# Copia sua configuração
COPY librechat.yaml /app/librechat.yaml

# Permissões APENAS onde o app grava dados
RUN mkdir -p /app/api/logs /app/uploads /app/client/public/images && \
    chown -R 10001:10001 /app/api/logs /app/uploads /app/client/public/images /app/librechat.yaml

ENV HOST=0.0.0.0
ENV PORT=3080
EXPOSE 3080

USER 10001

CMD ["node", "api/server/index.js"]
