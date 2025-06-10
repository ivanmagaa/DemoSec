# Proyecto DemoSec - Sistema SIEM con Wazuh y ELK Stack

##  Descripción General

**DemoSec** es un proyecto demostrativo y formativo que consiste en la implementación de un sistema de monitorización y detección de intrusiones (SIEM) basado en **Wazuh 4.7.5** y **ELK Stack (Elasticsearch, Logstash y Kibana)**, desplegado sobre una infraestructura virtualizada. El sistema está diseñado para:

- Simular un entorno empresarial real con diferentes sistemas operativos.
- Monitorizar eventos y responder ante amenazas.
- Servir como recurso formativo para centros educativos o departamentos de IT.
- Facilitar la replicabilidad mediante scripts automatizados y documentación.

##  Objetivos del Proyecto

- Implementar una arquitectura SIEM con Wazuh + ELK.
- Monitorizar clientes Ubuntu, Windows y Kali Linux.
- Detectar actividades sospechosas (brute-force, escaneos, malware, etc.).
- Configurar respuestas automáticas ante amenazas.
- Automatizar la instalación mediante scripts.
- Crear material formativo (presentaciones, guías, etc.).

---

##  Requisitos del Sistema

### Hardware (orientativo):
- CPU: 4 vCPU
- RAM: 8 GB (mínimo)
- Almacenamiento: 100 GB SSD

### Software:
- Ubuntu Server 20.04 LTS (Wazuh y ELK)
- Windows 10 Pro (agente)
- Kali Linux (simulación de ataques)
- VirtualBox / Proxmox / VMware / KVM

### Red:
- Conectividad entre VMs
- IPs fijas recomendadas

---

##  Infraestructura Virtualizada

```bash
+------------------+        +-------------------------+
|                  |        |                         |
| Kali Linux       +------->+     Wazuh Manager       |
| (Simulación de    |        |  + ELK Stack (Ubuntu)  |
| ataques)         |        |                         |
+------------------+        +-------------------------+
                                ^              ^
                                |              |
          +---------------------+              +------------------+
          |                                                   |
+------------------+                              +------------------+
| Ubuntu Client    |                              | Windows 10 Client |
| (agente Wazuh)   |                              | (agente Wazuh)    |
+------------------+                              +------------------+
```

---

##  Instalación Paso a Paso

### 1. Clonar el Repositorio
```bash
git clone https://github.com/ivanmagaa/DemoSec.git
cd proyecto-wazuh-demos
```

### 2. Ejecutar el Script Principal
```bash
chmod +x demosec-install.sh
./demosec-install.sh
```

El script incluye:
- Instalación de Wazuh Manager + Dashboard
- Instalación de ELK Stack
- Integración completa con Wazuh
- Configuración de alertas por email
- Opciones de personalización

### 3. Configuración de Agentes
- Ubuntu:
```bash
curl -s https://packages.wazuh.com/4.7/wazuh-install.sh | bash
```
- Windows:
  Descargar desde el dashboard o ejecutar el instalador con token generado.

---

## Pruebas de Funcionamiento

- Simulaciones con Kali Linux:
  - Ataques de fuerza bruta SSH (Hydra)
  - Escaneos de puertos (Nmap)
  - Descarga del fichero EICAR (simulación de malware)

- Resultados esperados:
  - Alertas en Kibana
  - Correos automáticos
  - Bloqueos de IP automáticos (active response)

---

## Alertas por Correo Electrónico

- Se utiliza **Postfix** configurado como relay a Gmail u otro SMTP.
- Configurable desde el script o manualmente:
```bash
/etc/postfix/main.cf
/etc/wazuh-manager/ossec.conf
```

---

##  Documentación Incluida

- `instalar_wazuh.sh`: Script automatizado completo.
- `README.md`: Este documento explicativo.
- `presentacion.pptx`: Presentación para exposición de 10-15 minutos.
- `esquema_diagrama.png`: Arquitectura visual del sistema.
- `manual_configuracion.md`: Guía manual para personalizaciones.

---

##  Futuras Mejoras

- Despliegue en Docker o Kubernetes.
- Integración con SIEMs externos (Splunk, etc.).
- Dashboards personalizados para roles (SOC, IT, etc.).
- Soporte para más sistemas operativos.

---

##  Autor y Licencia

- **Autor:** [Tu nombre o nick]
- **Centro educativo / empresa:** [Nombre del centro o entidad]
- **Licencia:** MIT License

---

##  Enlaces últiles

- [https://documentation.wazuh.com](https://documentation.wazuh.com)
- [https://www.elastic.co/elk-stack](https://www.elastic.co/elk-stack)
- [https://github.com/wazuh/wazuh](https://github.com/wazuh/wazuh)

---

Gracias por usar este proyecto. ¡Cualquier sugerencia, pull request o mejora es bienvenida!
