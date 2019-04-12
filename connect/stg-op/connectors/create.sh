#!/bin/bash


# docker run -it --rm --name runner -h runner -v ~/aesakroton.visualstudio.com/shared_services/kapacitor_clusters/connect/stg-op/connectors:/connectors -w /connectors ubuntu:trusty /bin/bash -c "apt-get update && apt-get -y install gettext-base && apt-get -y install jq && apt-get -y install curl && /connectors/create.sh"

# docker run -it --rm --name runner -h runner -v ./connect/stg-op/connectors:/connectors -w /connectors ubuntu:trusty /bin/bash -c "apt-get update && apt-get -y install gettext-base && apt-get -y install jq && apt-get -y install curl && /connectors/create.sh"

# echo $pwd
# chown -R 1000:1000 .
# #docker run --rm --name runner -h runner -v $(pwd)/connect/stg-op/connectors:/connectors -w /connectors ubuntu:trusty /bin/bash -c "ls /connectors/ -l"
# docker run --name runner -h runner -v $(pwd)/connect/stg-op/connectors:/connectors -w /connectors ubuntu:trusty /bin/bash -c "apt-get update && apt-get -y install gettext-base && apt-get -y install jq && apt-get -y install curl && chmod +x create.sh && ls / && ./create.sh"

# if [ $# -eq 0 ]
# then
#     echo "Não foi informado o hostname e porta para o connect de sink"
#     echo "Sintaxe ./create.sh <connect_hostname_sink:port>"    
#     exit
# else
    echo " ---==> CREATING ENVIROMENT AVA"


    echo " ---==> VARIABLES"
    echo ""
    echo "CONNECT         >> "$connect_hostname
    echo "SCHEMA REGISTRY >> "$connect_schema_registry
    echo "URL             >> "$connect_url
    echo "USER            >> "$connect_user
    echo "PASS            >> "$connect_pass
    echo ""
    echo " ---==> CONNECTORS"
    echo ""

    ##Espera o connect estar ativo
    # echo " ---==> WAITING FOR CONNECT"
    # while ! curl http://$connect_hostname/
    # do
    #     echo "$(date '+%Y-%m-%d %H:%M:%S') - Aguardando container 'connect'... $connect_hostname"
    #     sleep 5
    # done
    # echo "$(date '+%Y-%m-%d %H:%M:%S') - Connect Online!"



    echo " ---==> CREATING CONNECTORES"
    #for filename in ./ambientes/dev/connectors/sink/json/*.json; do
    for filename in ./*.json; do

        [ -e "$filename" ] || continue

        #export content=$(cat $filename | jq -rc .)
        export content=$(envsubst < $filename | jq -c .)

        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
        echo "Creating $filename"
        echo ""
        echo $content
        #curl -i -H "Content-Type: application/json" -X POST --data "$content" http://$connect_hostname/connectors
        echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
        sleep 3

    done

    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    echo ">>>>>>>>>>>>>>>>>>>> Conectores carregados com sucesso <<<<<<<<<<<<<<<<<<<<<<<<<"
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    #sleep infinity

# fi


