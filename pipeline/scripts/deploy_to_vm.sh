#!/bin/bash
set -e

IP=$1
SSH_KEY=$2
SCRIPT_PATH=$3

echo "Esperando que SSH esté disponible en ${IP}..."
timeout 60 bash -c "until nc -z -v -w5 ${IP} 22; do echo 'Esperando SSH...'; sleep 5; done"

echo "Copiando script de despliegue a la VM..."
scp -o StrictHostKeyChecking=no -i "${SSH_KEY}" "${SCRIPT_PATH}" ubuntu@"${IP}":/home/ubuntu/

echo "Dando permisos y ejecutando script de despliegue..."
ssh -o StrictHostKeyChecking=no -i "${SSH_KEY}" ubuntu@"${IP}" "chmod +x /home/ubuntu/$(basename ${SCRIPT_PATH}) && /home/ubuntu/$(basename ${SCRIPT_PATH})"
