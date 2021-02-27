#!/usr/bin/env bash
# exit on error
set -o errexit

echo "==> Initialize package manager and install basic utilities"
export DEBIAN_FRONTEND=noninteractive

echo "===> Updating package repos"
apt-get update -qq

echo "===> Installing locale $LANG"
LANG=C apt-get -qq install locales

echo "===> Updating system packages"
apt-get -qq upgrade

echo "===> Installing apt deps"
apt-get -qq install dialog apt-utils

echo "===> Installing utilities"
apt-get -qq install wget curl unzip make git

echo "==> Install ASDF plugin dependencies"

echo "===> Installing ASDF common plugin deps"
apt-get -qq install automake autoconf libreadline-dev libncurses-dev libssl-dev \
	libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev

echo "===> Installing ASDF Erlang plugin deps"
apt-get -qq install build-essential libncurses5-dev libwxgtk3.0-dev libgl1-mesa-dev \
	libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop

echo "===> Installing ASDF Node.js plugin deps"
apt-get -qq install dirmngr gpg

echo "==> Install ASDF and plugins"

if [ ! -d "$HOME/.asdf" ]; then
	echo "===> Installing ASDF"
	git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.8.0

	echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
	echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
fi

source "$HOME/.asdf/asdf.sh"

if [ ! -d "$ASDF_DIR/plugins/erlang" ]; then
	echo "===> Installing ASDF erlang plugin"
	asdf plugin-add erlang
fi

if [ ! -d "$ASDF_DIR/plugins/elixir" ]; then
	echo "===> Installing ASDF elixir plugin"
	asdf plugin-add elixir
fi

if [ ! -d "$ASDF_DIR/plugins/nodejs" ]; then
	echo "===> Installing ASDF nodejs plugin"
	asdf plugin-add nodejs

	echo "===> Importing Node.js release team OpenPGP keys to main keyring"
	# This can be flaky
	bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
fi

echo "===> Installing build deps with ASDF"
asdf install
# Run it again to make sure all the plugins ran, as there have been issues with return codes in the past
asdf install
