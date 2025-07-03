#!/bin/bash
set -e

export TF_VAR_private_key_path="$1"
ACTION="$2"

cd "$(dirname "$0")/../../terraform"

rm -rf .terraform/modules
terraform init -upgrade
terraform plan -out=tfplan

if [ "$ACTION" = "apply" ]; then
  terraform apply -auto-approve tfplan

  # Obtener IP pública
  IP=$(terraform output -raw instance_public_ip)

  # Crear archivo HTML con link (sin crear archivo .txt)
  cat > instance_public_ip.html <<EOF
  <!DOCTYPE html>
  <html lang="es">
  <head>
    <meta charset="UTF-8">
    <title>Acceso a la instancia</title>
  </head>
  <body>
    <h1>Acceso a la instancia</h1>
    <p>Haz clic en el siguiente enlace para acceder a la instancia:</p>
    <a href="http://$IP" target="_blank">http://$IP</a>
  </body>
  </html>
EOF

elif [ "$ACTION" = "destroy" ]; then
  terraform destroy -auto-approve
else
  echo "Acción no soportada: $ACTION"
  exit 1
fi
