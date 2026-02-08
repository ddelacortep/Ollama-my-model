# Usamos la imagen oficial de Ollama
FROM ollama/ollama:latest

# Copiamos tu Modelfile dentro del contenedor
COPY ./Modelfile /tmp/Modelfile

# Este comando es el "truco" para que el modelo se guarde DENTRO de la imagen
# 1. Arranca Ollama en segundo plano
# 2. Espera a que esté listo
# 3. Crea tu modelo personalizado
# 4. Apaga Ollama para terminar la construcción
RUN nohup bash -c "ollama serve &" && \
    sleep 5 && \
    ollama create assistent-novadynamics -f /tmp/Modelfile && \
    pkill ollama

# Exponemos el puerto estándar
EXPOSE 11434

ENTRYPOINT ["ollama", "serve"]