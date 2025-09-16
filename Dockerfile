## Escolher a imagem do Docker Hub
FROM httpd

## Copiar arquivos do webserver para o container
## COPY origem destino
COPY website/ /usr/local/apache2/htdocs/

## Expose porta 80
EXPOSE 80

