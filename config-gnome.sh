#!/usr/bin/env bash

#################
### VARIABLES ###
#################

# Pour affichage texte enrichi dans le terminal
TXT_BOLD="\033[1m"
TXT_RED="\033[31m"
TXT_GREEN="\033[32m"
TXT_YELLOW="\033[33m"
TXT_CYAN="\033[36m"
TXT_RESET="\033[0m"

# Modèle de l'ordinateur
HARDWARE_MODEL=$(hostnamectl | sed -n 's/^ *Hardware Model: //p')

# Informations sur la distribution
if [[ -e "/etc/os-release" ]]; then
	OS_RELEASE="/etc/os-release"
	# Lit le fichier contenant des variables et les défini dans le script préfixées de OSR_
	eval "$(sed 's/^/OSR_/' "${OS_RELEASE}")"
	echo
	echo -e "${TXT_BOLD}Distribution :${TXT_RESET} ${OSR_PRETTY_NAME:-Inconnue}"
	echo
else
	echo
	echo -e "${TXT_RED}${TXT_BOLD}ERREUR⤳${TXT_RESET} Impossible de récupérer les informations sur la distribution utilisée !"
	echo
	exit 1
fi

#####################
### FIN VARIABLES ###
#####################

#################
### FONCTIONS ###
#################

check_cmd() {
	if [[ $? -eq 0 ]]; then
		echo -e "${TXT_GREEN}✔${TXT_RESET}"
	else
		echo -e "${TXT_RED}✖${TXT_RESET}"
	fi
}

#####################
### FIN FONCTIONS ###
#####################

####################
### DEBUT SCRIPT ###
####################

### VERIFICATION PRÉLIMINAIRES

## Si bien non root
if [[ "$EUID" -eq 0 ]]; then
	echo -e "${TXT_RED}${TXT_BOLD}ERREUR⤳${TXT_RESET} Ce script doit être lancé sans les privilèges root (su - ou sudo) !"
	echo
	exit 1
fi

### CONFIGURATION SPÉCIFIQUE DE GNOME
echo -e "${TXT_BOLD}Configuration spécifique de GNOME ${TXT_RESET}"
echo

## Debian
if [[ ${OSR_ID} == "debian" ]]; then
	echo "Debian"
	# rien pour l'instant
	echo
fi

## Fedora
if [[ ${OSR_ID} == "fedora" ]]; then
	echo "Fedora"

	echo -n " ↳ Personnaliser le logo Fedora (filigrane sur fond d'écran) "
	gsettings set org.fedorahosted.background-logo-extension logo-always-visible true && \
	gsettings set org.fedorahosted.background-logo-extension logo-opacity 222
	check_cmd

	echo
fi

## Ubuntu
if [[ ${OSR_ID} == "ubuntu" ]]; then
	echo "Ubuntu"

	echo -n " ↳ Masquer le dossier personnel sur le bureau "
	gsettings set org.gnome.shell.extensions.ding show-home false
	check_cmd

	echo -n " ↳ Position des nouvelles icônes sur le bureau : en haut à droite "
	gsettings set org.gnome.shell.extensions.ding start-corner 'top-right'
	check_cmd

	echo -n " ↳ Désactiver le son de démarrage "
	gsettings set org.gnome.shell.ubuntu startup-sound ''
	check_cmd

	echo
fi

## Lenovo ThinkPad X9-15 gen 1
if [[ "$HARDWARE_MODEL" == "ThinkPad X9-15 Gen 1" ]]; then
	echo "Lenovo ThinkPad X9-15 gen 1"

	echo -n " ↳ Désactiver le Built-in Scaling for Legacy Apps "
	gsettings set org.gnome.mutter.wayland xwayland-scaling-factor 1.0
	check_cmd

	echo
fi

### CONFIGURATION GLOBALE DE GNOME
echo -e "${TXT_BOLD}Configuration globale de GNOME ${TXT_RESET}"
echo

## Configuration générale
echo "Générale"

echo -n " ↳ Appliquer le thème sombre "
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
check_cmd

echo -n " ↳ Arrangement des boutons de fenêtre "
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
check_cmd

echo -n " ↳ Centrer les nouvelles fenêtres "
gsettings set org.gnome.mutter center-new-windows true
check_cmd

echo -n " ↳ Désactiver le coin actif "
gsettings set org.gnome.desktop.interface enable-hot-corners false
check_cmd

echo -n " ↳ Configurer le format de la date/heure "
gsettings set org.gnome.desktop.interface clock-format '24h' && \
gsettings set org.gtk.Settings.FileChooser clock-format '24h' && \
gsettings set org.gnome.desktop.interface clock-show-date true && \
gsettings set org.gnome.desktop.interface clock-show-weekday true
check_cmd

echo -n " ↳ Afficher le numéro de semaine dans le calendrier "
gsettings set org.gnome.desktop.calendar show-weekdate true
check_cmd

echo -n " ↳ Configurer le mode nuit "
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true && \
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false && \
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 19.0 && \
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 9.0
check_cmd

echo -n " ↳ Action du bouton d'extinction : ne rien faire "
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'
check_cmd

echo -n " ↳ Désactiver les sons système "
gsettings set org.gnome.desktop.sound event-sounds false && \
gsettings set org.gnome.desktop.wm.preferences audible-bell false
check_cmd

echo -n " ↳ Configurer la souris/le touchpad "
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false && \
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers' && \
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true && \
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false && \
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.15 && \
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false && \
gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
check_cmd

echo

## Configuration de la confidentialité
echo "Confidentialité"

echo -n " ↳ Désactiver la localisation "
gsettings set org.gnome.system.location enabled false
check_cmd

echo -n " ↳ Désactiver les notifications sur l'écran verrouillé "
gsettings set org.gnome.desktop.notifications show-in-lock-screen false
check_cmd

echo -n " ↳ Désactiver l'envoi de rapports sur des problèmes techniques "
gsettings set org.gnome.desktop.privacy report-technical-problems false
check_cmd

echo -n " ↳ Désactiver l'envoi de statistiques quand des applications sont installées/supprimées "
gsettings set org.gnome.desktop.privacy send-software-usage-stats false
check_cmd

echo -n " ↳ Epuration de l'historique, des fichiers temporaires et de la corbeille de plus de 30 jours "
gsettings set org.gnome.desktop.privacy recent-files-max-age '30' && \
gsettings set org.gnome.desktop.privacy old-files-age '30' && \
gsettings set org.gnome.desktop.privacy remove-old-temp-files true && \
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
check_cmd

echo

### CONFIGURATION DES APPLICATIONS GNOME
echo -e "${TXT_BOLD}Configuration des applications GNOME ${TXT_RESET}"
echo

## Configuration de GNOME Software
echo "GNOME Software"

echo -n " ↳ Désactiver le téléchargement/l'installation automatique des mises à jour "
gsettings set org.gnome.software download-updates false
check_cmd

echo -n " ↳ Afficher les applications propriétaires "
gsettings set org.gnome.software show-only-free-apps false
check_cmd

echo -n " ↳ Afficher les applications non vérifiées "
gsettings set org.gnome.software show-only-verified-apps false
check_cmd

echo

## Configuration de GNOME Text Editor
echo "GNOME Text Editor"

echo -n " ↳ Afficher les numéros de lignes "
gsettings set org.gnome.TextEditor show-line-numbers true
check_cmd

echo -n " ↳ Surligner la ligne actuelle "
gsettings set org.gnome.TextEditor highlight-current-line true
check_cmd

echo -n " ↳ Configurer la taille de l'indentation (4) "
gsettings set org.gnome.TextEditor tab-width 4
check_cmd

echo -n " ↳ Désactiver la vérification orthographique "
gsettings set org.gnome.TextEditor spellcheck false
check_cmd

echo -n " ↳ Ne pas restaurer la session précédente "
gsettings set org.gnome.TextEditor restore-session false
check_cmd

echo

## Configuration de l'explorateur de fichier Nautilus
echo "Nautilus"

echo -n " ↳ Afficher les dossiers en premier "
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true && \
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
check_cmd

echo -n " ↳ Configurer le double clic pour ouvrir les éléments "
gsettings set org.gnome.nautilus.preferences click-policy 'double'
check_cmd

echo

## Configuration du terminal Ptyxis
echo "Ptyxis"

echo -n " ↳ Désactiver la restauration de la session/taille "
gsettings set org.gnome.Ptyxis restore-session false && \
gsettings set org.gnome.Ptyxis restore-window-size false
check_cmd

echo -n " ↳ Configurer la taille de la fenêtre "
gsettings set org.gnome.Ptyxis default-columns 90 && \
gsettings set org.gnome.Ptyxis default-rows 32
check_cmd

echo

### CONFIGURATION DES EXTENSIONS DE GNOME
echo -e "${TXT_BOLD}Configuration des extensions GNOME ${TXT_RESET}"
echo

## Activation / désactivation des extensions
if [[ ${OSR_ID} == "ubuntu" ]]; then
	echo "Désactivation des extensions préinstallées"
	ubuntu_extensions_disable=("ding@rastersoft.com" "snapd-search-provider@canonical.com" "web-search-provider@ubuntu.com")
	for extension in ${ubuntu_extensions_disable[@]}; do
		echo -n " ↳ Désactiver l'extension $extension "
		gnome-extensions disable $extension
		check_cmd
	done
elif [[ ${OSR_ID} == "debian" ]]; then
	echo "Activation des extensions installées"
	if [[ -z "$(gnome-extensions list --disabled)" ]]; then
		echo -n " ↳ Il n'y a aucune extension installée à activer"
	else
		echo -n " ↳ Autoriser les extensions "
		gsettings set org.gnome.shell disable-user-extensions false
		check_cmd
		for extension in $(gnome-extensions list --disabled); do
			echo -n " ↳ Activer l'extension $extension "
			gnome-extensions enable $extension
			check_cmd
		done
	fi
fi
echo

## Configuration des extensions installées
echo "Configuration des extensions installées"

# Le dock Ubuntu est basé sur Dash to Dock avec les mêmes paramètres gsettings mais un identifiant différent !
if gnome-extensions info dash-to-dock@micxgx.gmail.com > /dev/null 2>&1 || gnome-extensions info ubuntu-dock@ubuntu.com > /dev/null 2>&1; then
	echo -n " ↳ Personnaliser l'extension Dash to Dock/Ubuntu Dock "
	gsettings set org.gnome.shell.extensions.dash-to-dock animation-time 0.05 && \
	gsettings set org.gnome.shell.extensions.dash-to-dock background-color 'rgb(34,34,38)' && \
	gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.9 && \
	gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize' && \
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color true && \
	gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink false && \
	gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true && \
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false && \
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM' && \
	gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false && \
	gsettings set org.gnome.shell.extensions.dash-to-dock hide-delay 0.1 && \
	gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor true && \
	gsettings set org.gnome.shell.extensions.dash-to-dock pressure-threshold 50 && \
	gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true && \
	gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS' && \
	gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows' && \
	gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true && \
	gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false && \
	gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
	check_cmd
fi

echo
