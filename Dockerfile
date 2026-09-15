FROM ghcr.io/danny-avila/librechat:latest

USER root

# Copia sua configuração personalizada com Gemini e NVIDIA
COPY librechat.yaml /app/librechat.yaml

# O Choreo EXIGE um UID numérico entre 10000 e 20000.
# Damos a posse da pasta /app para o usuário 10001 para que ele consiga escrever logs e cache.
RUN chown -R 10001:10001 /app

ENV HOST=0.0.0.0
ENV PORT=3080
EXPOSE 3080

# Choreo roda com este usuário
USER 10001

CMD ["npm", "run", "backend"]
