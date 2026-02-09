# 🐧 UbunTunning: Security & Connectivity Workstation by Jhon Barrera

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)
![Author](https://img.shields.io/badge/Author-Jhon%20Barrera-0077B5?logo=linkedin)

**UbunTunning** es un script de automatización diseñado para transformar una instalación fresca de Ubuntu en una estación de trabajo robusta para **Ciberseguridad**.

Este proyecto agiliza el despliegue de herramientas esenciales para profesionales de seguridad, configurando no solo el software, sino también el entorno visual y la terminal.

## 🛠️ Arsenal de Herramientas (Stack Tecnológico)

El script automatiza la instalación y configuración de las siguientes categorías:

### 🛡️ Ciberseguridad & Pentesting
* **Reconocimiento:** `Nmap`, `Zenmap`, `DNSRecon`, `SSLScan`.
* **Análisis Web:** `Nikto`, `Wafw00f`.
* **Explotación:** `Metasploit Framework`.
* **Inteligencia (OSINT):** `Maltego` (v4.11.1).
* **Análisis de Red:** `Wireshark`, `Net-tools`.

### 💻 Entorno de Desarrollo & Sistema
* **Lenguajes:** `Python3` (+ `pip`, `venv`), `Java` (Default JRE).
* **Control de Versiones:** `Git`.
* **Gestión del Sistema:** `Gufw` (Firewall), `Timeshift` (Backups/Snapshots), `Htop` (via `btop/lsd`).
* **Utilidades:** `Wget`, `Curl`, `Scrot` (Capturas), `Libnss3-tools`.

### 🌐 Conectividad & Navegación
* **VPN Corporativa:** `FortiClient VPN` (Soporte SSLVPN/IPsec).
* **Navegadores:** `Google Chrome Stable`.
* **Multimedia:** `VLC Media Player`.

### 🎨 Personalización (Look & Feel)
* **Shell:** `ZSH` con **Oh My Zsh**.
* **Tema:** `Powerlevel10k` (Configuración predefinida).
* **Terminal:** `Kitty` + `Tmux`.
* **Fuentes:** `Hack Nerd Font` y `JetBrains Mono Nerd Font`.
* **Plugins ZSH:** `zsh-autosuggestions`, `zsh-syntax-highlighting`.
* **Estética Visual:** `LSD` (ls con iconos), `Bat` (cat mejorado), personalización del Dock de GNOME (transparencia y posición).

## ⚙️ ¿Qué hace el script internamente?

1.  **Elevación de Privilegios:** Configura temporalmente `sudoers` para evitar solicitar contraseña repetidamente durante la instalación automatizada.
2.  **Gestión de Paquetes:** Actualiza (`update/upgrade`) el sistema e instala las dependencias base necesarias.
3.  **Fuentes y Temas:** Descarga e instala fuentes *Nerd Fonts* (Hack y JetBrains) y configura el tema *Powerlevel10k*.
4.  **Configuración de Dotfiles:** Copia automáticamente tus archivos de configuración (`.zshrc`, `.p10k.zsh`, `kitty.conf`) desde la carpeta `config_files` a tu directorio personal.
5.  **Instalación de Software Externo:** Descarga e instala paquetes `.deb` externos (Chrome, Maltego, FortiClient VPN) y ejecuta el script de instalación de Metasploit.
6.  **Hardening de UI:** Ajusta la configuración del entorno GNOME (posición del Dock, extensiones, transparencia) mediante `gsettings`.
7.  **Limpieza:** Al finalizar, ofrece la opción interactiva de eliminar los archivos temporales y los instaladores descargados.

---
## 🚀 Instalación Rápida

```bash
git clone https://github.com/jhondbarrera/linux_scripts.git
cd linux_scripts
chmod +x ubuntunning.sh
./ubuntunning.sh
```

> [!WARNING] Aviso de Privilegios: El script configura temporalmente el acceso NOPASSWD en sudoers para facilitar la instalación masiva. Se recomienda auditar este ajuste post-instalación según los requisitos de seguridad de su organización.

---
## 👤 Autor

**Jhon Barrera** *Ingeniero de Telecomunicaciones | Especialista en Seguridad Informática | Lider Implementador ISO 27001*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jhondbarrera/)

## 📄 Licencia

Este proyecto está bajo la [Licencia MIT](LICENSE).