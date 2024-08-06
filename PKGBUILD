pkgname=emcrepo
_pkgname=emcrepo
pkgdesc="Emercoin apt repo configuration & repo signing key - debian package"
pkgver='0.8.4'
_pkgver=${pkgver}
pkgrel=1
_pkgrel=${pkgrel}
arch=( 'any' )
_pkgarches=('amd64' ) # 'arm64' 'armhf' 'armel')
makedepends=('dpkg')
depends=()
_debdeps=""

build() {
	#create the apt repo config
	echo "deb http://deb.emercoin.com  sid main
	# deb-src http://deb.emercoin.com sid main" | tee ${srcdir}/emercoin.list
	#create the pubkey file
	gpg --export DE08F924EEE93832DABC642CA8DC761B1C0C0CFC | tee ${srcdir}/emercoin.gpg
	#create the update script
	echo "#!/bin/bash
		apt update -o Dir::Etc::sourcelist=/etc/apt/sources.list.d/emercoin.list &&	apt -qq --yes reinstall emercoin-bin && systemctl is-active --quiet install-emercoin && systemctl disable install-emercoin 2> /dev/null" | tee ${srcdir}/install-emercoin.sh
	#create the update service
	echo "[Unit]
	Description=install emercoin service
	After=network-online.target
	Wants=network-online.target

	[Service]
	Type=simple
	ExecStart=/bin/install-emercoin

	[Install]
	WantedBy=multi-user.target
	" | tee ${srcdir}/install-emercoin.service

	#create the DEBIAN/control files
  for _i in ${_pkgarches[@]}; do
		_msg2 "_pkgarch=${_i}"
	  local _pkgarch=${_i}
		_msg2 "Creating DEBIAN/control file for ${_pkgarch}"
		echo "Package: ${_pkgname}" > ${srcdir}/${_pkgarch}.control
		echo "Version: ${_pkgver}-${_pkgrel}" >> ${srcdir}/${_pkgarch}.control
		echo "Priority: optional" >> ${srcdir}/${_pkgarch}.control
		echo "Section: web" >> ${srcdir}/${_pkgarch}.control
		echo "Architecture: ${_pkgarch}" >> ${srcdir}/${_pkgarch}.control
		echo "Depends: ${_debdeps}" >> ${srcdir}/${_pkgarch}.control
		echo "Maintainer: emercoin" >> ${srcdir}/${_pkgarch}.control
		echo "Description: ${pkgdesc}" >> ${srcdir}/${_pkgarch}.control
		cat ${srcdir}/${_pkgarch}.control
	done
}

package() {
  for _i in ${_pkgarches[@]}; do
  _msg2 "_pkgarch=${_i}"
  local _pkgarch=${_i}
   echo ${_pkgarch}
  #set up to create a .deb package with dpkg
  _debpkgdir="${_pkgname}-${pkgver}-${_pkgrel}-${_pkgarch}"
  _pkgdir="${pkgdir}/${_debpkgdir}"
  #########################################################################
  #package normally here using ${_pkgdir} instead of ${pkgdir}
  _msg2 "Creating dirs"
  mkdir -p ${_pkgdir}/etc/apt/sources.list.d/
  mkdir -p ${_pkgdir}/etc/apt/trusted.gpg.d/
  mkdir -p ${_pkgdir}/usr/bin/
	mkdir -p ${_pkgdir}/etc/systemd/system/
	_msg2 "Installing install-emercoin.sh emercoin installation script"
	install -Dm755 ${srcdir}/install-emercoin.sh ${_pkgdir}/usr/bin/install-emercoin
	_msg2 "Installing install-emercoin.service service for install-emercoin.sh"
	install -Dm644 ${srcdir}/install-emercoin.service ${_pkgdir}/etc/systemd/system/install-emercoin.service
  _msg2 "Installing apt repository configuration to:\n    /etc/apt/sources.list.d/emercoin.list"
  install -Dm644 ${srcdir}/emercoin.list ${_pkgdir}/etc/apt/sources.list.d/emercoin.list
  _msg2 "Installing apt repository signing key to:\n    /etc/apt/trusted.gpg.d/emercoin.gpg"
  install -Dm644 ${srcdir}/emercoin.gpg ${_pkgdir}/etc/apt/trusted.gpg.d/emercoin.gpg
  #########################################################################
  _msg2 'Installing control file and postinst script'
  install -Dm755 ${srcdir}/${_pkgarch}.control ${_pkgdir}/DEBIAN/control
  _msg2 'Creating the debian package'
  cd $pkgdir
	if command -v tree &> /dev/null ; then
	_msg2 'package tree'
	  tree -a ${_debpkgdir}
	fi
	dpkg-deb --build -z9 ${_debpkgdir}
  mv *.deb ../../
  done
	#clean up manually just in case
	rm -rf ${srcdir}
  #exit so the arch package doesn't get built
  exit
}

_msg2() {
	(( QUIET )) && return
	local mesg=$1; shift
	printf "${BLUE}  ->${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@"
}
