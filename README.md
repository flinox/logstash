# Introduction 
Imagem para logstash captura eventos, dados, estatisticas, informações de diversas origens e levar para um destino para monitoração!
Essa imagem permite implementar para rodar como um microserviço em um POD Kubernetes!

# Logstash
O Logstash é um pipeline gratuito e aberto de processamento de dados do lado do servidor que faz a ingestão de dados de inúmeras fontes, transforma-os e envia-os para o seu "esconderijo" favorito. 
[logstash](https://www.elastic.co/pt/logstash/)


# Configuracao
Só configurar os arquivos .config na pasta config, e adicionar as chamadas no arquivo run.sh
ou adaptar da maneira que preferir


# Local Test

docker build -t flinox/backbone-logger:latest .

docker run --rm -it --hostname backbone-logger --name backbone-logger \
--mount type=bind,source="$(pwd)"/sink,target=/app/sink/ \
--security-opt label=disable \
flinox/backbone-logger:latest \
/bin/bash






