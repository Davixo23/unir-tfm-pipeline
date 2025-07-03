#!/bin/bash
echo "Actualizando paquetes..."
sudo apt-get update -y

echo "Instalando Git..."
sudo apt-get install -y git

echo "Instalando Docker..."
if ! command -v docker &> /dev/null; then
  sudo apt-get install -y docker.io
  sudo systemctl enable docker
  sudo systemctl start docker
else
  echo "Docker ya está instalado."
fi

echo "Instalando Nginx (fuera de Docker, si es necesario)..."
if ! command -v nginx &> /dev/null; then
  sudo apt-get install -y nginx
  sudo systemctl enable nginx
  sudo systemctl start nginx
else
  echo "Nginx ya está instalado."
  sudo systemctl enable nginx
  sudo systemctl start nginx
fi

echo "Configurando iptables para HTTP (puerto 80)..."
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT

echo "Instalando iptables-persistent para guardar reglas..."
sudo apt-get install -y iptables-persistent
sudo netfilter-persistent save

echo "Instalación y configuración completada."

echo "Versiones instaladas:"
echo -n "Git version: "
git --version

echo -n "Docker version: "
docker --version

echo -n "Nginx version: "
nginx -v