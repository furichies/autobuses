#!/bin/bash

BASE_URL="http://localhost"
REGISTRO_API_URL="$BASE_URL:6900"
RESERVAS_API_URL="$BASE_URL:7000"
BANCA_API_URL="$BASE_URL:6901"
TIENDA_API_URL="$BASE_URL:8888"

menu_principal() {
  clear
  echo "### Menú Principal ###"
  echo "1. Registro"
  echo "2. Reservas"
  echo "3. Tienda"
  echo "4. Banca"
  echo "0. Salir"
  echo
  read -p "Ingrese su opción: " opcion

  case $opcion in
    1) registro_menu;;
    2) reservas_menu;;
    3) tienda_menu;;
    4) banca_menu;;
    0) exit;;
    *) echo "Opción inválida. Intente nuevamente.";;
  esac
}

registro_menu() {
  clear
  echo "### Menú de Registro ###"
  echo "1. Registro"
  echo "2. Verificar"
  echo "0. Volver al menú principal"
  echo
  read -p "Ingrese su opción: " opcion

  case $opcion in
    1) registro;;
    2) verificar;;
    0) menu_principal;;
    *) echo "Opción inválida. Intente nuevamente.";;
  esac
}

registro() {
  clear
  echo "### Registro ###"
  read -p "Ingrese su nombre: " nombre
  read -p "Ingrese sus apellidos: " apellidos
  read -p "Ingrese su token: " token

  # Realizar la solicitud al endpoint correspondiente
  response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"nombre": "'"$nombre"'", "apellidos": "'"$apellidos"'", "token": "'"$token"'"}' $REGISTRO_API_URL/registro)
  echo $response
  read -p "Presione Enter para continuar..."
  registro_menu
}

verificar() {
  clear
  echo "### Verificar Registro ###"
  read -p "Ingrese su nombre: " nombre
  read -p "Ingrese sus apellidos: " apellidos

  # Realizar la solicitud al endpoint correspondiente
  response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"nombre": "'"$nombre"'", "apellidos": "'"$apellidos"'"}' $REGISTRO_API_URL/verificar)
  echo $response
  read -p "Presione Enter para continuar..."
  registro_menu
}

reservas_menu() {
  clear
  echo "### Menú de Reservas ###"
  echo "1. Consultar Asientos"
  echo "2. Ocupar Asiento"
  echo "3. Desocupar Asiento"
  echo "0. Volver al menú principal"
  echo
  read -p "Ingrese su opción: " opcion

  case $opcion in
    1) consultar_asientos;;
    2) ocupar_asiento;;
    3) desocupar_asiento;;
    0) menu_principal;;
    *) echo "Opción inválida. Intente nuevamente.";;
  esac
}

consultar_asientos() {
  clear
  echo "### Consultar Asientos ###"

  # Realizar la solicitud al endpoint correspondiente
  response=$(curl -s $RESERVAS_API_URL/asientos)
  echo $response
  read -p "Presione Enter para continuar..."
  reservas_menu
}

ocupar_asiento() {
  clear
  echo "### Ocupar Asiento ###"
  read -p "Ingrese el número de asiento: " numero_asiento
  read -p "Ingrese el nombre del cliente: " nombre_cliente

  # Realizar la solicitud al endpoint correspondiente
  response=$(curl -s -X PUT -H "Content-Type: application/json" -d '{"numero": '"$numero_asiento"', "cliente": "'"$nombre_cliente"'"}' $RESERVAS_API_URL/asientos/ocupar)
  echo $response
  read -p "Presione Enter para continuar..."
  reservas_menu
}

desocupar_asiento() {
  clear
  echo "### Desocupar Asiento ###"
  read -p "Ingrese el número de asiento: " numero_asiento

  # Realizar la solicitud al endpoint correspondiente
  response=$(curl -s -X PUT -H "Content-Type: application/json" -d '{"numero": '"$numero_asiento"'}' $RESERVAS_API_URL/asientos/desocupar)
  echo $response
  read -p "Presione Enter para continuar..."
  reservas_menu
}

tienda_menu() {
  clear
  echo "### Menú de Tienda ###"
  echo "1. Comprar"
  echo "0. Volver al menú principal"
  echo
  read -p "Ingrese su opción: " opcion

  case $opcion in
    1) comprar;;
    0) menu_principal;;
    *) echo "Opción inválida. Intente nuevamente.";;
  esac
}

comprar() {
  clear
  echo "### Comprar ###"
  read -p "Ingrese su nombre: " nombre
  read -p "Ingrese su token: " token

  # Realizar la solicitud al endpoint correspondiente
  response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"nombre": "'"$nombre"'", "token": "'"$token"'"}' $TIENDA_API_URL/comprar)
  echo $response
  read -p "Presione Enter para continuar..."
  tienda_menu
}

banca_menu() {
  clear
  echo "### Menú de Banca ###"
  echo "1. Registro"
  echo "2. Saldo"
  echo "3. Pagar"
  echo "4. Ingreso"
  echo "0. Volver al menú principal"
  echo
  read -p "Ingrese su opción: " opcion

  case $opcion in
    1) registro_banca;;
    2) saldo;;
    3) pagar;;
    4) ingreso;;
    0) menu_principal;;
    *) echo "Opción inválida. Intente nuevamente.";;
  esac
}

registro_banca() {
  clear
  echo "### Registro en Banca ###"
  read -p "Ingrese su nombre: " nombre

  # Realizar la solicitud al endpoint correspondiente
  response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"nombre": "'"$nombre"'"}' $BANCA_API_URL/registro)
  echo $response
  read -p "Presione Enter para continuar..."
  banca_menu
}

saldo() {
  clear
  echo "### Consultar Saldo ###"
  read -p "Ingrese su nombre: " nombre

  # Realizar la solicitud al endpoint correspondiente
  response=$(curl -s $BANCA_API_URL/saldo?nombre=$nombre)
  echo $response
  read -p "Presione Enter para continuar..."
  banca_menu
}

pagar() {
  clear
  echo "### Realizar Pago ###"
  read -p "Ingrese su nombre: " nombre
  read -p "Ingrese el costo: " costo

  # Realizar la solicitud al endpoint correspondiente
  response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"nombre": "'"$nombre"'", "costo": '"$costo"'}' $BANCA_API_URL/pagar)
  echo $response
  read -p "Presione Enter para continuar..."
  banca_menu
}

ingreso() {
  clear
  echo "### Ingresar Dinero ###"
  read -p "Ingrese su nombre: " nombre
  read -p "Ingrese la cantidad a ingresar: " cantidad

  # Realizar la solicitud al endpoint correspondiente
  response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"nombre": "'"$nombre"'", "cantidad": '"$cantidad"'}' $BANCA_API_URL/ingreso)
  echo $response
  read -p "Presione Enter para continuar..."
  banca_menu
}

# Ejecutar el menú principal
menu_principal
