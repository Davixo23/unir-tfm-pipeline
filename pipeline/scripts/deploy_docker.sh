#!/bin/bash
set -e

DEPLOY_DIR="/home/ubuntu"
cd "$DEPLOY_DIR"

echo "Actualizando sistema e instalando Nginx si no está instalado..."

if ! command -v nginx &> /dev/null; then
  sudo apt update
  sudo apt install -y nginx
  sudo systemctl enable nginx
  sudo systemctl start nginx
else
  echo "Nginx ya está instalado."

  if ! sudo systemctl is-enabled nginx &> /dev/null; then
    sudo systemctl enable nginx
  fi

  if ! sudo systemctl is-active nginx &> /dev/null; then
    sudo systemctl start nginx
  fi
fi

echo "Eliminando configuraciones por defecto de Nginx..."

sudo rm -f /etc/nginx/sites-enabled/default
sudo rm -f /etc/nginx/sites-enabled/000-default || true

echo "Descargando imagen Docker desde Docker Hub..."

sudo docker pull davixo/restaurant-proyecto-basico:latest

echo "Deteniendo y eliminando contenedor antiguo (si existe)..."

sudo docker rm -f restaurant-app || true

echo "Ejecutando contenedor restaurant-app en puerto 3000..."

sudo docker run -d --name restaurant-app -p 3000:3000 davixo/restaurant-proyecto-basico:latest

echo "Creando configuración personalizada de Nginx para proxy inverso..."

NGINX_CONF_PATH="/etc/nginx/sites-available/restaurant_app.conf"

sudo tee "$NGINX_CONF_PATH" > /dev/null <<'EOF'
server {
    listen 80;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
EOF

echo "Habilitando configuración personalizada de Nginx..."

sudo ln -sf "$NGINX_CONF_PATH" /etc/nginx/sites-enabled/restaurant_app.conf

echo "Probando configuración de Nginx..."

sudo nginx -t

echo "Recargando Nginx para aplicar cambios..."

sudo systemctl reload nginx

echo "Despliegue completado con éxito."
