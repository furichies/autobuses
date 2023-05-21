#!/bin/bash

BASE_URL="http://localhost:8888"

function mostrar_menu_principal {
    clear
    echo "=== Menú Principal ==="
    echo "1. Verificar usuario"
    echo "2. Ingresar dinero a la cuenta"
    echo "3. Registrarse"
    echo "4. Salir"
    echo "======================"
    echo -n "Seleccione una opción: "
}

function verificar_usuario {
    echo -n "Ingrese el nombre del usuario: "
    read nombre

    echo -n "Ingrese el token: "
    read token

    echo -n "Realizando verificación del usuario..."

    response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"nombre": "'"$nombre"'", "token": "'"$token"'"}' "$BASE_URL/comprar")

    mensaje=$(echo "$response" | jq -r '.mensaje')

    echo ""
    echo "Respuesta del servidor: $mensaje"
    echo ""
    echo "Presione Enter para continuar..."
    read
}

function ingresar_dinero {
    echo -n "Ingrese el nombre del usuario: "
    read nombre

    echo -n "Ingrese la cantidad de dinero a ingresar: "
    read dinero

    echo -n "Realizando ingreso de dinero..."

    response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"nombre": "'"$nombre"'", "apellidos": "", "ingreso": '$dinero'}' "$BASE_URL/ingreso")

    mensaje=$(echo "$response" | jq -r '.mensaje')
    saldo=$(echo "$response" | jq -r '.saldo')

    echo ""
    echo "Respuesta del servidor: $mensaje"
    echo "Saldo actual: $saldo"
    echo ""
    echo "Presione Enter para continuar..."
    read
}

function registrarse {
    echo -n "Ingrese el nombre: "
    read nombre

    echo -n "Ingrese los apellidos: "
    read apellidos

    echo -n "Realizando registro..."

    response=$(curl -s -X POST -H "Content-Type: application/json" -d '{"nombre": "'"$nombre"'", "apellidos": "'"$apellidos"'"}' "$BASE_URL/registro")

    mensaje=$(echo "$response" | jq -r '.mensaje')
    saldo=$(echo "$response" | jq -r '.saldo')

    echo ""
    echo "Respuesta del servidor: $mensaje"
    echo "Saldo inicial: $saldo"
    echo ""
    echo "Presione Enter para continuar..."
    read
}

while true; do
    mostrar_menu_principal

    read opcion

    case $opcion in
        1)
            verificar_usuario
            ;;
        2)
            ingresar_dinero
            ;;
        3)
            registrarse
            ;;
        4)
            echo "Saliendo..."
            break
            ;;
        *)
            echo "Opción inválida. Intente nuevamente."
            ;;
    esac
done

