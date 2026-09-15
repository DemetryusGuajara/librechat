FROM ghcr.io/danny-avila/librechat:latest

USER root

# Copia sua configuração personalizada com Gemini e NVIDIA
COPY librechat.yaml /app/librechat.yaml

# Atualiza a biblioteca
RUN cd /app && npm install websocket-driver@0.7.5 --save || true

# O Choreo EXIGE um UID numérico entre 10000 e 20000.
# Damos a posse da pasta /app para o usuário 10001 (incluindo o que acabou de ser instalado)
RUN chown -R 10001:10001 /app

ENV HOST=0.0.0.0
ENV PORT=3080
EXPOSE 3080

# Choreo roda com este usuário
USER 10001

CMD ["npm", "run", "backend"]
