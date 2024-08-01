#! /usr/bin/env bash

# VERIF si root
if [[ $(id -u) -eq "0" ]]
then
	echo -e "\033[31mATTENTION\033[0m Si vous lancez ce script en root, cela personnalisera la session GNOME de root !"
	echo "Poursuite du script dans 30 secondes..."
	sleep 30
fi


echo "Configuration générale de GNOME"
echo " - Arrangement des boutons de fenêtre"
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
echo " - Centrage des nouvelles fenêtres"
gsettings set org.gnome.mutter center-new-windows true
echo " - Désactivation des sons système"
gsettings set org.gnome.desktop.sound event-sounds false
gsettings set org.gnome.desktop.wm.preferences audible-bell false
echo " - Modification du format de la date et heure"
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds false
gsettings set org.gnome.desktop.interface clock-show-weekday true
echo " - Affichage du numéro de semaine dans le calendrier"
gsettings set org.gnome.desktop.calendar show-weekdate true
echo " - Activation du mode nuit"
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 19.0
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 9.0
echo " - Paramétrage touchpad/souris"
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad speed 0.5
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click false
gsettings set org.gnome.desktop.peripherals.mouse natural-scroll false
gsettings set org.gnome.desktop.peripherals.mouse speed 0.5


echo "Personnalisation de GNOME"
echo " - Application du thème sombre"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
echo " - Application du thème d'icônes Yaru"
gsettings set org.gnome.desktop.interface icon-theme 'Yaru-blue-dark'
echo " - Remplacement du fond d'écran par la couleur par défaut"
gsettings set org.gnome.desktop.background picture-uri ''
gsettings set org.gnome.desktop.background picture-uri-dark ''
gsettings set org.gnome.desktop.background primary-color '#023c88'
gsettings set org.gnome.desktop.background secondary-color '#5789ca'

echo "Confidentialité de GNOME"
echo " - Désactivation de l'envoi des rapports"
gsettings set org.gnome.desktop.privacy report-technical-problems false
echo " - Désactivation des statistiques des logiciels"
gsettings set org.gnome.desktop.privacy send-software-usage-stats false
echo " - Epuration de l'historique, des fichiers temporaires et de la corbeille de plus de 30 jours"
gsettings set org.gnome.desktop.privacy recent-files-max-age '30'
gsettings set org.gnome.desktop.privacy old-files-age '30'
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
echo " - Désactivation des notifications sur l'écran verrouillé"
gsettings set org.gnome.desktop.notifications show-in-lock-screen false
echo " - Désactivation de la localisation"
gsettings set org.gnome.system.location enabled false


echo "Configuration de GNOME Logiciels"
echo " - Désactivation du téléchargement automatique des mises à jour"
gsettings set org.gnome.software download-updates false
echo " - Activation de l'affichage des logiciels propriétaires"
gsettings set org.gnome.software show-only-free-apps false


echo "Configuration de GNOME Text Editor"
gsettings set org.gnome.TextEditor highlight-current-line true
gsettings set org.gnome.TextEditor restore-session false
gsettings set org.gnome.TextEditor show-line-numbers true
gsettings set org.gnome.TextEditor spellcheck false


echo "Configuration de Nautilus"
echo " - Configuration de la taille des icônes"
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small-plus'
echo " - Configuration du double clic pour ouvrir les éléments"
gsettings set org.gnome.nautilus.preferences click-policy 'double'
echo " - Affichage des dossiers en premier"
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true
gsettings set org.gtk.Settings.FileChooser sort-directories-first true


echo "Activation de l'extension Dash-to-dock"
gnome-extensions enable dash-to-dock@micxgx.gmail.com
echo " - Personnalisation de l'extension"
gsettings set org.gnome.shell.extensions.dash-to-dock autohide false
gsettings set org.gnome.shell.extensions.dash-to-dock background-color 'rgb(36,31,49)'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.75
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color true
gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 42
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock height-fraction 0.9
gsettings set org.gnome.shell.extensions.dash-to-dock multi-monitor true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'
gsettings set org.gnome.shell.extensions.dash-to-dock scroll-action 'cycle-windows'
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'


echo "Activation de l'extension AppIndicator"
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com
echo " - Personnalisation de l'extension"
gsettings set org.fedorahosted.background-logo-extension logo-always-visible true
gsettings set org.fedorahosted.background-logo-extension logo-opacity 222


echo "Personnalisation terminée."
