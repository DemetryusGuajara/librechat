FROM ghcr.io/danny-avila/librechat:latest

USER root

# Copia sua configuração personalizada
COPY librechat.yaml /app/librechat.yaml

# Damos permissão APENAS nas pastas onde o app realmente precisa gravar dados.
# Isso roda em 0.2 segundos em vez de 15 minutos!
RUN mkdir -p /app/api/logs /app/uploads /app/client/public/images && \
    chown -R 10001:10001 /app/api/logs /app/uploads /app/client/public/images /app/librechat.yaml

ENV HOST=0.0.0.0
ENV PORT=3080
EXPOSE 3080

# Choreo roda com este usuário
USER 10001

CMD ["npm", "run", "backend"]
