#!/usr/bin/env bash

###############
# PREPARATION #
###############

# FONCTIONS
check_cmd() {
	if [[ $? -eq 0 ]]; then
		#echo -e "\033[32mOK\033[0m"
		echo -e "\033[32m\xE2\x9C\x94\033[0m" # vu vert
	else
		#echo -e "\033[31mERREUR\033[0m"
		echo -e "\033[31m\xE2\x9D\x8C\033[0m" # croix rouge
	fi
}

# VERIF si root
if [[ $(id -u) -eq "0" ]]; then
	echo -e "\033[31mATTENTION\033[0m"
	echo "Si vous lancez ce script en root, cela personnalisera la session GNOME de root !"
	echo "Poursuite du script dans 30 secondes..."
	echo -e "[CTRL]+[C] pour annuler\n"
	sleep 30
fi

# RECUP les infos sur la distribution pour les configs spécifiques
if [[ -e /etc/os-release ]]; then
	os_release="/etc/os-release"
	. "${os_release}"
	echo "Distribution : ${PRETTY_NAME}"
	echo
fi

################
# CONFIG GNOME #
################

# Config spécifique à Fedora
if [[ ${ID} == "fedora" ]]; then
	echo "Configuration spécifique à Fedora"
	echo -e " - Arrangement des boutons de fenêtre \c"
	gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
	check_cmd
	if rpm -q yaru-theme > /dev/null 2>&1; then # si thème Yaru installé
		echo -e " - Appliquer le thème d'icônes Yaru \c"
		gsettings set org.gnome.desktop.interface icon-theme 'Yaru-blue-dark'
		check_cmd
	fi
	echo -e " - Personnaliser le logo Fedora (filigrane sur fond d'écran) \c"
	gsettings set org.fedorahosted.background-logo-extension logo-always-visible true
	gsettings set org.fedorahosted.background-logo-extension logo-opacity 222
	check_cmd
	echo -e " - Activer l'extension AppIndicator \c"
	gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
	check_cmd
	echo -e " - Activer l'extension Dash-to-dock  \c"
	gnome-extensions enable dash-to-dock@micxgx.gmail.com
	check_cmd
	echo
fi

# Config spécifique à Ubuntu
if [[ ${ID} == "ubuntu" ]]; then
	echo "Configuration spécifique à Ubuntu"
	echo -e " - Position des nouvelles icônes sur le bureau : en haut à droite \c"
	gsettings set org.gnome.shell.extensions.ding start-corner 'top-right'
	check_cmd
	echo -e " - Masquer le dossier personnel sur le bureau \c"
	gsettings set org.gnome.shell.extensions.ding show-home false
	check_cmd
	echo -e " - Désactiver le son de démarrage \c"
	gsettings set org.gnome.shell.ubuntu startup-sound ''
	check_cmd
	echo
fi

# Config globale
echo "Configuration générale de GNOME"
echo -e " - Centrer les nouvelles fenêtres \c"
gsettings set org.gnome.mutter center-new-windows true
check_cmd
echo -e " - Configurer le format de la date/heure \c"
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds false
gsettings set org.gnome.desktop.interface clock-show-weekday true
check_cmd
echo -e " - Afficher le numéro de semaine dans le calendrier \c"
gsettings set org.gnome.desktop.calendar show-weekdate true
check_cmd
echo -e " - Configurer le mode nuit \c"
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 19.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 9.0
check_cmd
echo -e " - Configurer le touchpad/la souris \c"
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers' # clique secondaire à 2 doigts
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.25
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.mouse speed 0.5
check_cmd
echo -e " - Désactiver les sons système \c"
gsettings set org.gnome.desktop.sound event-sounds false
gsettings set org.gnome.desktop.wm.preferences audible-bell false
check_cmd
echo -e " - Action du bouton d'extinction : ne rien faire \c"
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'
check_cmd
echo

echo "Configuration de l'apparence de GNOME"
echo -e " - Appliquer le thème sombre \c"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
check_cmd
echo

echo "Configuration de la confidentialité de GNOME"
echo -e " - Désactiver l'envoi de rapports sur des problèmes techniques \c"
gsettings set org.gnome.desktop.privacy report-technical-problems false
check_cmd
echo -e " - Désactiver l'envoi de statistiques quand des applications sont installées/supprimées \c"
gsettings set org.gnome.desktop.privacy send-software-usage-stats false
check_cmd
echo -e " - Epuration de l'historique, des fichiers temporaires et de la corbeille de plus de 30 jours \c"
gsettings set org.gnome.desktop.privacy recent-files-max-age '30'
gsettings set org.gnome.desktop.privacy old-files-age '30'
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
check_cmd
echo -e " - Désactiver les notifications sur l'écran verrouillé \c"
gsettings set org.gnome.desktop.notifications show-in-lock-screen false
check_cmd
echo -e " - Désactiver la localisation \c"
gsettings set org.gnome.system.location enabled false
check_cmd
echo

echo "Configuration de GNOME Software"
echo -e " - Désactiver le téléchargement/l'installation automatique des mises à jour \c"
gsettings set org.gnome.software download-updates false
check_cmd
echo -e " - Afficher les applications propriétaires \c"
gsettings set org.gnome.software show-only-free-apps false
check_cmd
echo

echo "Configuration de GNOME Text Editor"
echo -e " - Afficher les numéros de lignes \c"
gsettings set org.gnome.TextEditor show-line-numbers true
check_cmd
echo -e " - Surligner la ligne actuelle \c"
gsettings set org.gnome.TextEditor highlight-current-line true
check_cmd
echo -e " - Désactiver la vérification orthographique \c"
gsettings set org.gnome.TextEditor spellcheck false
check_cmd
echo -e " - Ne pas restaurer la session précédente \c"
gsettings set org.gnome.TextEditor restore-session false
check_cmd
echo

echo "Configuration de Nautilus"
echo -e " - Afficher les dossiers en premier \c"
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
check_cmd
echo -e " - Configurer la taille des icônes \c"
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small-plus'
check_cmd
echo -e " - Configurer le double clic pour ouvrir les éléments \c"
gsettings set org.gnome.nautilus.preferences click-policy 'double'
check_cmd
echo

echo "Configuration de l'extension Dash-to-dock"
echo -e " - Personnaliser le dock \c"
gsettings set org.gnome.shell.extensions.dash-to-dock autohide false
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.0
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true # réduire les marges
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 40
gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true # dock toujours visible
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false # désactiver mode panneau
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
check_cmd
echo

echo "Configuration terminée."
