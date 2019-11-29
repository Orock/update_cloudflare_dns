#!/bin/bash

if [ -z "$CLOUDFLARE_TOKEN" ]; then
  printf "Falta la variable de entorno CLOUDFLARE_TOKEN\n"
  exit 0
fi

if [ -z "$CLOUDFLARE_ZONE_ID" ]; then
  printf "Falta la variable de entorno CLOUDFLARE_ZONE_ID\n"
  exit 0
fi

if [ -z "$CLOUDFLARE_DNS_RECORD_ID" ]; then
  printf "Falta la variable de entorno CLOUDFLARE_DNS_RECORD_ID\n"
  exit 0
fi

if [ -z "$CLOUDFLARE_DOMAIN_NAME" ]; then
  printf "Falta la variable de entorno CLOUDFLARE_DOMAIN_NAME\n"
  exit 0
fi

CURRENT_PUBLIC_IP=$(wget ifconfig.me -q -O -)

FILE="current_ip"
if test -f "$FILE"; then
  LAST_PUBLIC_IP=`cat ${FILE}`
else
  LAST_PUBLIC_IP=""
fi

if [ "$LAST_PUBLIC_IP" = "$CURRENT_PUBLIC_IP" ]; then 
  echo "Nada que actualizar" 
else
  CLOUDFLARE_ENDPOINT="https://api.cloudflare.com/client/v4/zones/${CLOUDFLARE_ZONE_ID}/dns_records/${CLOUDFLARE_DNS_RECORD_ID}"
  DATA='{"type":"A","name":"'"$CLOUDFLARE_DOMAIN_NAME"'","content":"'"$CURRENT_PUBLIC_IP"'"}'

  printf "Actualizando ${CLOUDFLARE_DOMAIN_NAME}\n"
  printf "IP Publica ${CURRENT_PUBLIC_IP}\n"

  RESPONSE=$(curl -sX PUT "${CLOUDFLARE_ENDPOINT}" \
              -H "Authorization: ${CLOUDFLARE_TOKEN}" \
              -H "Content-Type: application/json" \
              --data ${DATA}
          )

  RESULT=$(echo ${RESPONSE} | grep -Po '"success":\w*' | grep -Po 'true|false')

  printf "Succes: ${RESULT}\n"

  if [ "$RESULT" = "true" ]; then 
    echo "$CURRENT_PUBLIC_IP" > current_ip
  fi;

fi;

exit 0
