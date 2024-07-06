#!/bin/bash

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # Sin color

consultar_bin() {
  read -p "Introduce el BIN: " BIN
  API_URL="https://data.handyapi.com/bin/$BIN"

  # Realiza la solicitud a la API
  RESPONSE=$(curl -s $API_URL)

  # Extrae y muestra los datos del BIN usando grep y sed
  STATUS=$(echo $RESPONSE | grep -o '"Status":"[^"]*' | sed 's/"Status":"//' | sed 's/"//')
  SCHEME=$(echo $RESPONSE | grep -o '"Scheme":"[^"]*' | sed 's/"Scheme":"//' | sed 's/"//')
  TYPE=$(echo $RESPONSE | grep -o '"Type":"[^"]*' | sed 's/"Type":"//' | sed 's/"//')
  ISSUER=$(echo $RESPONSE | grep -o '"Issuer":"[^"]*' | sed 's/"Issuer":"//' | sed 's/"//')
  CARD_TIER=$(echo $RESPONSE | grep -o '"CardTier":"[^"]*' | sed 's/"CardTier":"//' | sed 's/"//')
  COUNTRY_NAME=$(echo $RESPONSE | grep -o '"Name":"[^"]*' | sed 's/"Name":"//' | sed 's/"//')
  LUHN=$(echo $RESPONSE | grep -o '"Luhn":[^,]*' | sed 's/"Luhn"://' | sed 's/[{}]//')

  echo -e "${BLUE}Datos del BIN ${YELLOW}$BIN${NC}:"
  echo -e "${GREEN}Estado: ${NC}$STATUS"
  echo -e "${GREEN}Esquema: ${NC}$SCHEME"
  echo -e "${GREEN}Tipo: ${NC}$TYPE"
  echo -e "${GREEN}Emisor: ${NC}$ISSUER"
  echo -e "${GREEN}Nivel de la tarjeta: ${NC}$CARD_TIER"
  echo -e "${GREEN}País: ${NC}$COUNTRY_NAME"
  echo -e "${GREEN}Luhn válido: ${NC}$LUHN"
}

banner() {
  echo -e "${YELLOW}"
  echo "     /\\_/\\                                        "
  echo "    ( o.o )                                       "
  echo "     > ^ <                                         "
  echo -e "${NC}"
}

while true; do
  clear
  banner
  
  echo -e "${BLUE}Seleccione una opción:${NC}"
  echo -e "${YELLOW}1. Consultar BIN${NC}"
  echo -e "${YELLOW}2. Salir${NC}"
  read -p "Opción: " opcion

  case $opcion in
    1)
      consultar_bin
      ;;
    2)
      echo -e "${RED}Saliendo...${NC}"
      exit 0
      ;;
    *)
      echo -e "${RED}Opción no válida, por favor intente de nuevo.${NC}"
      ;;
  esac

  read -p "Presiona Enter para continuar..."
done