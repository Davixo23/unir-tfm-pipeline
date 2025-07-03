#!/bin/bash
echo "Actualizando paquetes..."
sudo apt-get update -y

echo "Instalando Git..."
sudo apt-get install -y git

echo "Verificando que Docker está instalado..."
if ! command -v docker &> /dev/null; then
  echo "Docker no está instalado, por favor instálalo primero."
  exit 1
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
