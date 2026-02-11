#!/bin/bash

# Colores
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

# Banner en verde
echo -ne "${GREEN}"
cat << "EOF"
  _    _ _                 _                       _             
 | |  | | |               | |                     (_)            
 | |  | | |__  _   _ _ __ | |_ _   _ _ __  _ __  _ _ __   __ _ 
 | |  | | '_ \| | | | '_ \| __| | | | '_ \| '_ \| | '_ \ / _` |
 | |__| | |_) | |_| | | | | |_| |_| | | | | | | | | | | | (_| |
  \____/|_.__/ \__,_|_| |_|\__|\__,_|_| |_|_| |_|_|_| |_|\__, |
                                                          __/ |
                                                         |___/ 
                            by Jhon Barrera
EOF
echo -e "${RESET}"

sleep 2
echo -e "[+] Tunning script for Ubuntu - by Jhon Barrera.${RESET}"
sleep 3
echo -e "\n${BLUE}[*] Configurando la instalación..${RESET}\n"
sleep 3

RPATH=`pwd`
REAL_USER=`whoami`
TEMP_DIR="$RPATH/temp_dir"
TOOLS_LIST="git gh python3 python3-venv python3-pip vim scrot zsh lsd kitty tmux bat zenmap nmap sslscan dnsrecon nikto wafw00f net-tools binutils traceroute wireshark wget curl gnome-tweaks gnome-shell-extension-manager libnss3-tools default-jre timeshift vlc gufw neofetch pssh"
mkdir ~/.config/kitty/
rm -rf $TEMP_DIR
mkdir -p $TEMP_DIR
cd $TEMP_DIR

# Configurar sudoers para que no solicite contraseña
echo -e "${YELLOW}[CONFIG] Configurando privilegios NOPASSWD para $REAL_USER...${NC}"
sudo echo "$REAL_USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$REAL_USER > /dev/null
sudo chmod 0440 /etc/sudoers.d/$REAL_USER

# Actualizar repos y sistema
echo -e "\n${BLUE}[*] Actualizando paquetes..${RESET}\n"
sudo apt update && sudo apt upgrade -y

# Instalar paquetes
echo -e "\n${BLUE}[*] Instalando paquetes..${RESET}\n"
sudo apt install -y $TOOLS_LIST

# Instalando Hack Nerd Font y JetBarins Mono Nerd Fonts
echo -e "\n${BLUE}[*] Instalando fuentes..${RESET}\n"
mkdir -p $TEMP_DIR/fonts
wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip -O  $TEMP_DIR/Hack.zip
wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip -O $TEMP_DIR/JetBrainsMono.zip
unzip -q $TEMP_DIR/Hack.zip -d $TEMP_DIR/fonts
unzip -q $TEMP_DIR/JetBrainsMono.zip -d $TEMP_DIR/fonts
mkdir -p ~/.local/share/fonts
mv  $TEMP_DIR/fonts/*.ttf ~/.local/share/fonts/
fc-cache -fv

# Instalando ohmyzsh
echo -e "\n${BLUE}[*] Instalando OhMyZSH..${RESET}\n"
rm -rf ~/.oh-my-zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Instalando powerlevel10k
echo -e "\n${BLUE}[*] Instalando tema powerlevel10k..${RESET}\n"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
rm -f ~/.p10k.zsh
cp -v $RPATH/config_files/p10k.zsh ~/.p10k.zsh

# Instalando plugins de zsh
echo -e "\n${BLUE}[*] Instalando plugins de ZSH..${RESET}\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
rm -f ~/.zshrc
cp -v $RPATH/config_files/zshrc ~/.zshrc
cp -v $RPATH/config_files/color.ini ~/.config/kitty/
cp -v $RPATH/config_files/kitty.conf ~/.config/kitty/

# Instalación FortiClient VPN
echo -e "${YELLOW}[DOWNLOAD] Descargando FortiClient VPN...${NC}"
wget -O forticlient_vpn.deb https://links.fortinet.com/forticlient/deb/vpnagent
echo -e "${YELLOW}[INSTALL] Instalando FortiClient...${NC}"
sudo apt install -y ./forticlient_vpn.deb

# Instalación Chrome
echo -e "${YELLOW}[INSTALL] Actualizando sistema e instalando dependencias base...${NC}"
sudo apt install -y wget gnupg2 software-properties-common apt-transport-https ca-certificates curl
echo -e "${YELLOW}[INSTALL] Configurando repositorio de Google Chrome...${NC}"
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor --yes -o /usr/share/keyrings/google-chrome.gpg
sudo echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install -y google-chrome-stable

# Instalación maltego
echo -e "${YELLOW}[DOWNLOAD] Descargando Maltego...${NC}"
# Nota: Verifica periódicamente si el enlace de versión sigue activo
wget -O maltego.deb https://downloads.maltego.com/maltego-v4/linux/Maltego.v4.11.1.deb
chmod +x maltego.deb
echo -e "${YELLOW}[INSTALL] Instalando Maltego...${NC}"
sudo apt install -y ./maltego.deb

#Instalación VSCode
echo -e "${YELLOW}[DOWNLOAD] Visual Studio Code...${NC}"
wget -O vscode.deb https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
chmod +x vscode.deb
echo -e "${YELLOW}[INSTALL] Instalando Visual Studio Code...${NC}"
sudo apt install -y ./vscode.deb

#Instalacion MSF
echo -e "${YELLOW}[DOWNLOAD] Descargando Metasploit Framework...${NC}"
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

#Personalización del dock
echo -e "${YELLOW}[CONFIG] Personalizando el Dock de GNOME para $REAL_USER...${NC}"
## Definir el bus para que root pueda hablar con la sesión de del usuario
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u "$REAL_USER")/bus"
## Definir el orden exacto de las aplicaciones
APPS_ORDER="['kitty.desktop', 'code.desktop', 'firefox_firefox.desktop', 'google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'wireshark.desktop']"
## Aplicar configuración del Dock
gsettings set org.gnome.shell favorite-apps "$APPS_ORDER"
SCHEMA="org.gnome.shell.extensions.dash-to-dock"
gsettings set $SCHEMA dock-position 'BOTTOM'
gsettings set $SCHEMA dock-fixed false
gsettings set $SCHEMA extend-height false
gsettings set $SCHEMA dash-max-icon-size 38
gsettings set $SCHEMA show-trash false
gsettings set $SCHEMA transparency-mode 'FIXED'
gsettings set $SCHEMA background-opacity 0.0

#Definiendo zsh como shell para el usuario
echo -e "${GREEN}------------------------------------------------${NC}"
echo -e "${GREEN}    Estableciendo zsh como shell por defecto    ${NC}"
echo -e "${GREEN}------------------------------------------------${NC}"
chsh -s /bin/zsh

# Configurar Ctrl+Alt+T para abrir Kitty
echo -e "${YELLOW}[CONFIG] Remapeando Ctrl+Alt+T a Kitty...${NC}"
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['']"
KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY_PATH name 'Abrir Kitty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY_PATH command '/usr/bin/kitty'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY_PATH binding '<Control><Alt>t'
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$KEY_PATH']"

# Limpieza y Finalización
echo -e "${GREEN}------------------------------------------------${NC}"
echo -e "${GREEN}      INSTALACIÓN COMPLETADA EXITOSAMENTE       ${NC}"
echo -e "${GREEN}------------------------------------------------${NC}"
echo -e "Software instalado:"
echo -e " - Google Chrome"
echo -e " - Herramientas: $TOOLS_LIST"
echo -e " - FortiClient VPN"
echo -e " - Maltego (v4.11.1)"
echo ""

# Pregunta interactiva para borrar temporales
while true; do
    read -p "¿Deseas eliminar el directorio temporal de instaladores ($TEMP_DIR)? [s/n]: " yn
    case $yn in
        [Ss]* ) 
            rm -rf "$TEMP_DIR"
            echo -e "${GREEN}[CLEANUP] Directorio eliminado.${NC}"
            break;;
        [Nn]* ) 
            echo -e "${YELLOW}[INFO] Directorio conservado en $TEMP_DIR.${NC}"
            break;;
        * ) echo "Por favor responde s (sí) o n (no).";;
    esac
done

echo -e "${GREEN}Script finalizado. ¡Tu entorno está listo!${NC}"
