# Terraform_LocalStack_ApiGateway_Lambda  

### Como executar o projeto:  
OBS1: A maneira escolhida para iniciar e gerenciar minha instância do LocalStack foi a CLI
do LocalStack. https://docs.localstack.cloud/get-started/#localstack-cli  
-> Digite no terminal o comando "localstack start -d" para criar um container do localstack.  
OBS2: Ao digitar o comando acima, caso tenha algum problema relacionado a permissão do 
Docker, tente usar o Docker como um usuário não root. https://docs.docker.com/engine/install/linux-postinstall/   
-> Digite no terminal(na Pasta raiz do projeto) o comando "terraform init" para baixar os providers utilizados utilizados no projeto.  
-> Digite no terminal(na Pasta raiz do projeto) "terraform plan" para ver o plano de execução que o terraform fará para criar os recursos do seu projeto.  
-> Digite no terminal(na Pasta raiz do projeto) "terraform apply" para aplicar os scripts do terraform e digite "yes" para prosseguir com o comando.  

### Descrição do projeto:  
Esse projeto utiliza o LocalStack e scripts Terraform para provisionamento da infraestrutura. Esses scripts vão realizar o provisionamento dos seguintes recursos:  
-> Um Lambda, com uma aplicação "echo server" (que também deve ser deployada pelo Terraform).  
-> Um API Gateway.  

### Requisitos de software e bibliotecas:  
-> Terraform e dependencias  
-> LocalStack e dependecias  

### Links úteis:  
GitHub do LocalStack: https://github.com/localstack/localstack
Documentação de instalação do LocalStack CLI: https://docs.localstack.cloud/get-started/#localstack-cli    
Documentação do localStack sobre apigateway: https://docs.localstack.cloud/aws/apigatewayv2/  
Documentação do Terraform sobre apigateway: https://registry.terraform.io/providers/hashicorp/aws/latest/docs  
Projeto que usa Node para construir uma Lambda e varias anotações importantes sobre conceitos
do Lambda: https://github.com/PedroAraujoNogueira/image-analisys  
Conceitos do Terraform: https://github.com/PedroAraujoNogueira/Terraform_Conceitos  
