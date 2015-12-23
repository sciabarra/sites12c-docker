FROM owcs/base-oracle:latest
RUN useradd -d /app app
WORKDIR /app
RUN mkdir -p /app/shared && chown -Rv app /app
USER app
VOLUME /app/shared
