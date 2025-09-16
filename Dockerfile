## Escolher a imagem do Docker Hub
FROM httpd

## Copiar arquivos do webserver para o container
## COPY origem destino
COPY . /usr/local/apache2/htdocs/

## Expose porta 80
EXPOSE 80

# Comando para iniciar o serviço httpd e ficar
# rodando em segundo plano sem que finalize o serviço.
# O container só vive enquanto há serviço rodando.
# CMD [ "httpd", "-g", "daemon off;" ]