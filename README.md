# lab-devops
Laboratório DevOps com Docker, AWS, Terraform e CI/CD

Suba uma aplicação (webserver) rodando em um container Docker em uma instância EC2 na AWS com Terraform e automatizando deploy com CI/CD via GitHub Actions

# Passo 0: Autenticar terminal na AWS
aws config
Entrar com Access Key e secret access key

# Passo 1: Criação do Dockerfile

# Passo 2: Buildar imagem com arquivos do site estático

# Passo 3: Criar e subir imagem no ECR da AWS
Efetuar o login do Docker no ECR com o comando:
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com

Obs.: Substituir região utilizada e substituir 123456789012 por ID da conta AWS

Criar uma imagem a partir de outra para ser enviada para o ECR:
docker tag NomeDaImagem:tag IDDaContaAWS.dkr.ecr.us-east-1.amazonaws.com/NomeDoRepositorioPrivado:tag

docker images

docker push IDDaContaAWS.dkr.ecr.us-east-1.amazonaws.com/NomeDoRepositorioPrivado:tag

# Passo 4: Subir uma instância EC2 e executar o container Docker dentro dela
Corrigir erro de execução do Docker no usuário não root:
sudo usermod -aG docker $USER


# Passo 5: Testar conectividade container via IP Público
Abrir no browser IPPublicoDaEC2:porta


# Passo 6: 