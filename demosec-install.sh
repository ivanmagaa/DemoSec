#!/bin/bash

# Script Automático para Instalación de Wazuh - Proyecto DemoSec

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

show_banner() {
    echo -e "${GREEN}"
    echo "###############################################"
    echo "#      WAZUH INSTALADOR AUTOMATIZADO          #"
    echo "#               Proyecto DemoSec              #"
    echo "###############################################"
    echo -e "${NC}"
}

elegir_version() {
    echo -e "${GREEN}[+]${NC} Introduce la versión de Wazuh que deseas instalar (ej. 4.7.5):"
    read WAZUH_VERSION
    echo -e "${GREEN}[+]${NC} Has seleccionado la versión: ${WAZUH_VERSION}"
}

configurar_correo_alertas() {
    echo -e "${GREEN}[+]${NC} Introduce la dirección de correo a la que se enviarán las alertas:"
    read EMAIL_ALERT
    echo -e "${GREEN}[+]${NC} Dirección configurada para alertas: $EMAIL_ALERT"

    echo "relayhost = [smtp.gmail.com]:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt" > /etc/postfix/main.cf

    echo "[smtp.gmail.com]:587 $EMAIL_ALERT:PASSWORD" > /etc/postfix/sasl_passwd
    postmap /etc/postfix/sasl_passwd
    systemctl restart postfix
}

mostrar_configuraciones_clave() {
    echo -e "${GREEN}[i]${NC} Las configuraciones clave están en:"
    echo " - /var/ossec/etc/ossec.conf → Configuración principal de Wazuh"
    echo " - /etc/filebeat/filebeat.yml → Configuración del agente Filebeat"
    echo " - /etc/logstash/conf.d/ → Filtros personalizados de Logstash"
    echo " - /usr/share/kibana/ → Archivos de interfaz de Kibana"
    echo " - /etc/postfix/ → Configuración de correo (alertas)"
    echo " - /var/ossec/active-response/ → Scripts de respuesta activa"
}

instalar_manager() {
    echo -e "${GREEN}[+] Instalando Wazuh Manager versión ${WAZUH_VERSION}...${NC}"
    curl -sO https://packages.wazuh.com/4.x/wazuh-install.sh
    bash ./wazuh-install.sh -v ${WAZUH_VERSION}
}

instalar_agente() {
    echo -e "${GREEN}[+] Instalando Wazuh Agent versión ${WAZUH_VERSION}...${NC}"
    curl -sO https://packages.wazuh.com/4.x/apt/wazuh-agent_${WAZUH_VERSION}-1_amd64.deb
    dpkg -i wazuh-agent_${WAZUH_VERSION}-1_amd64.deb
}

menu_instalacion() {
    echo -e "${GREEN}[?]${NC} ¿Qué componente quieres instalar?"
    echo "1) Servidor (Manager)"
    echo "2) Cliente (Agente)"
    echo "3) Salir"
    read -p "Opción: " OPC

    case $OPC in
        1) instalar_manager ;;
        2) instalar_agente ;;
        3) exit 0 ;;
        *) echo -e "${RED}Opción inválida.${NC}" ;;
    esac
}

menu_principal() {
    while true; do
        echo ""
        echo "========== MENU PRINCIPAL =========="
        echo "1) Elegir versión de Wazuh"
        echo "2) Configurar correo de alertas"
        echo "3) Instalar componentes (Manager o Agente)"
        echo "4) Mostrar ubicaciones de configuración"
        echo "5) Salir"
        read -p "Selecciona una opción: " opcion
        case $opcion in
            1) elegir_version ;;
            2) configurar_correo_alertas ;;
            3) menu_instalacion ;;
            4) mostrar_configuraciones_clave ;;
            5) exit 0 ;;
            *) echo -e "${RED}Opción no válida${NC}" ;;
        esac
    done
}

# Ejecución
show_banner
menu_principal
