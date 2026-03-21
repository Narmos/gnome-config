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

# Config spécifique à Debian
if [[ ${ID} == "debian" ]]; then
	echo "Configuration spécifique à Debian"
	echo
fi

# Config spécifique à Ubuntu
if [[ ${ID} == "ubuntu" ]]; then
	echo "Configuration spécifique à Ubuntu"
	echo
fi

# Config spécifique à Fedora
if [[ ${ID} == "fedora" ]]; then
	echo "Configuration spécifique à Fedora"
	echo
fi

# Config globale
echo "Configuration générale de GNOME"
echo

echo "Configuration terminée."
