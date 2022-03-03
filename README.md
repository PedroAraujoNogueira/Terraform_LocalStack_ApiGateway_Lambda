# Terraform_LocalStack_ApiGateway_Lambda  

### Como executar o projeto:  
-> Digite no terminal o comando "localstack start -d" para criar um container do localstack.  
OBS: Ao digitar o comando acima, caso tenha algum problema relacionado a permissão do 
Docker, tente usar o Docker como um usuário não root. https://docs.docker.com/engine/install/linux-postinstall/   
-> Digite no terminal(na Pasta raiz do projeto) o comando "terraform init" para baixar os providers utilizados utilizados no projeto.  
-> Digite no terminal(na Pasta raiz do projeto) "terraform plan" para ver o plano de execução que o terraform fará para criar os recursos do seu projeto.  
-> Digite no terminal(na Pasta raiz do projeto) "terraform apply" para aplicar os scripts do terraform e digite "yes" para prosseguir com o comando.  

### Descrição do projeto:  
Nesse projeto vamos utilizar o localstack para desenvolver scripts terraform para nossa aplicação. Esses scripts vão realizar o provisionamento dos seguintes recursos:  
-> Um Lambda, com uma aplicação "echo server" (que também deve ser deployada pelo terraform).  
-> Um API Gateway.  

### Requisitos de software e bibliotecas:  
-> Terraform e dependencias  
-> LocalStack e dependecias  

### Links úteis:  
GitHub do LocalStack: https://github.com/localstack/localstack  
Documentação do localStack sobre apigateway: https://docs.localstack.cloud/aws/apigatewayv2/  
Documentação do Terraform sobre apigateway: https://registry.terraform.io/providers/hashicorp/aws/latest/docs  
Projeto que usa Node para construir uma Lambda e varias anotações importantes sobre conceitos
do Lambda: https://github.com/PedroAraujoNogueira/image-analisys  
Conceitos do Terraform: https://github.com/PedroAraujoNogueira/Terraform_Conceitos  