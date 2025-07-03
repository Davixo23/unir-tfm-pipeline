#!/bin/bash
set -e

IP=$1
SSH_KEY=$2
SCRIPT_PATH=$3

echo "Esperando que SSH esté disponible en ${IP}..."

# Intentar conectar al puerto 22 hasta 60 segundos (12 intentos con 5 segundos de espera)
for i in {1..12}; do
  if timeout 5 bash -c "echo > /dev/tcp/${IP}/22" 2>/dev/null; then
    echo "Puerto SSH abierto en ${IP}"
    break
  else
    echo "Esperando SSH... intento ${i}/12"
    sleep 5
  fi
done

# Si el puerto sigue cerrado después de los intentos, salir con error
if ! timeout 5 bash -c "echo > /dev/tcp/${IP}/22" 2>/dev/null; then
  echo "Error: Puerto SSH no disponible en ${IP} después de esperar 60 segundos."
  exit 1
fi

echo "Copiando script de despliegue a la VM..."
scp -o StrictHostKeyChecking=no -i "${SSH_KEY}" "${SCRIPT_PATH}" ubuntu@"${IP}":/home/ubuntu/

echo "Dando permisos y ejecutando script de despliegue..."
ssh -o StrictHostKeyChecking=no -i "${SSH_KEY}" ubuntu@"${IP}" "chmod +x /home/ubuntu/$(basename ${SCRIPT_PATH}) && /home/ubuntu/$(basename ${SCRIPT_PATH})"
