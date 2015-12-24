FROM owcs/base-oracle:latest
RUN groupadd -g 2000 app && useradd -g 2000 -u 2000 -d /app app 
WORKDIR /app
RUN mkdir -p /app/shared && chown -Rv app /app
