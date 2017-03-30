# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit depend.apache eutils toolchain-funcs user systemd

MY_P="BackupPC-${PV}"

DESCRIPTION="High-performance backups to a server's disk"
HOMEPAGE="https://backuppc.github.io/backuppc"
SRC_URI="https://github.com/backuppc/backuppc/releases/download/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE="rss samba apache2 rrdtool systemd"

# The CGI modules are handled in $RDEPEND.
APACHE_MODULES="apache2_modules_alias," # RedirectMatch
APACHE_MODULES+="apache2_modules_authn_core," # AuthType
APACHE_MODULES+="apache2_modules_authz_core," # Require
APACHE_MODULES+="apache2_modules_authz_host," # Require host
APACHE_MODULES+="apache2_modules_authz_user" # Require valid-user

DEPEND="dev-lang/perl
	dev-perl/CGI
	dev-perl/File-Listing
	dev-perl/Archive-Zip
	>=dev-perl/BackupPC-XS-0.50
	>=net-misc/rsync-bpc-3.0.9.6
	apache2? ( app-admin/makepasswd app-admin/apache-tools )
"

# Older versions of mod_perl think they're compatibile with apache-2.4,
# so we require the new one explicitly.
RDEPEND="${DEPEND}
	app-arch/tar
	app-arch/gzip
	app-arch/bzip2
	net-misc/rsync
	rss? ( dev-perl/XML-RSS )
	rrdtool? ( net-analyzer/rrdtool[graph] )
	samba? ( net-fs/samba )
"

# need to test and see which ones are necessary
#	virtual/perl-IO-Compress
#	dev-perl/Archive-Zip
#	dev-perl/libwww-perl
#	app-arch/par2cmdline
#	virtual/mta
#	>=www-apache/mod_perl-2.0.9
#	www-apache/mpm_itk
#	|| ( >=www-servers/apache-2.4[${APACHE_MODULES},apache2_modules_cgi]
#		 >=www-servers/apache-2.4[${APACHE_MODULES},apache2_modules_cgid]
#		 >=www-servers/apache-2.4[${APACHE_MODULES},apache2_modules_fcgid] )
#	net-misc/rsync
#	dev-perl/File-RsyncP

need_apache2_4

S="${WORKDIR}/${MY_P}"

BPC_USER=backuppc
BPC_GROUP=${BPC_USER}

CGIDIR="/usr/lib/backuppc/htdocs"
CONFDIR="/etc/BackupPC"
DATADIR="/var/lib/backuppc"
DOCDIR="/usr/share/doc/${PF}"
LOGDIR="/var/log/BackupPC"
RUNDIR="/run/backuppc"

pkg_setup() {
	enewgroup ${BPC_GROUP}
	enewuser ${BPC_USER} -1 /bin/bash /var/lib/${PN} ${BPC_GROUP}
}

src_install() {

	#WD=${S}/dist/BackupPC-9999
	#einfo "Working Directory: ${WD}\n"

	#pushd ${WD}

	local myconf
	myconf=""
	if use samba ; then
		myconf="--bin-path smbclient=$(type -p smbclient)"
		myconf="${myconf} --bin-path nmblookup=$(type -p nmblookup)"
	fi

	if use rrdtool ; then
		myconf="${myconf} --bin-path rrdtool=$(type -p rrdtool)"
	fi

	/usr/bin/env perl ./configure.pl \
		--batch \
		--bin-path perl=$(type -p perl) \
		--bin-path tar=$(type -p tar) \
		--bin-path rsync=$(type -p rsync) \
		--bin-path ping=$(type -p ping) \
		--bin-path df=$(type -p df) \
		--bin-path ssh=$(type -p ssh) \
		--bin-path sendmail=$(type -p sendmail) \
		--bin-path hostname=$(type -p hostname) \
		--bin-path gzip=$(type -p gzip) \
		--bin-path bzip2=$(type -p bzip2) \
		--config-dir "${CONFDIR}" \
		--install-dir /usr \
		--data-dir "${DATADIR}" \
		--hostname 127.0.0.1 \
		--uid-ignore \
		--dest-dir "${D%/}" \
		--html-dir "${CGIDIR}"/image \
		--html-dir-url /image \
		--run-dir "${RUNDIR}" \
		--cgi-dir "${CGIDIR}" \
		--fhs \
		${myconf} || die "failed the configure.pl script"

	ebegin "Installing documentation"

	pod2man \
		-errors=none \
		--section=8 \
		--center="BackupPC manual" \
		"${S}"/doc/BackupPC.pod backuppc.8 \
		|| die "failed to generate man page"

	doman backuppc.8

	# Place the documentation in the correct location
	dodoc "${D}/usr/share/doc/BackupPC/BackupPC.html"
	dodoc "${D}/usr/share/doc/BackupPC/BackupPC.pod"
	rm -rf "${D}/usr/share/doc/BackupPC" || die
	eend 0

	# Setup directories
	dodir "${CONFDIR}/pc"

	keepdir "${CONFDIR}"
	keepdir "${CONFDIR}/pc"
	keepdir "${DATADIR}"/{trash,pool,pc,cpool}
	keepdir "${LOGDIR}"

	if ! use systemd ; then
		ebegin "Setting up OpenRC scripts"
		newinitd "${S}"/systemd/src/init.d/gentoo-backuppc backuppc
		newconfd "${S}"/systemd/src/init.d/gentoo-backuppc.conf backuppc
	fi

	if use systemd ; then
		ebegin "Setting up systemd scripts"
		systemd_dounit "${S}/systemd/src/${PN}.service"
	fi

	if use apache2 ; then
		einfo "Installing apache backuppc configuration in ${APACHE_MODULES_CONFDIR}"
		insinto "${APACHE_MODULES_CONFDIR}"
		doins "${FILESDIR}"/99_backuppc.conf
	fi

	# Make sure that the ownership is correct
	chown -R ${BPC_USER}:${BPC_GROUP} "${D}${CONFDIR}" || die
	chown -R ${BPC_USER}:${BPC_GROUP} "${D}${DATADIR}" || die
	chown -R ${BPC_USER}:${BPC_GROUP} "${D}${LOGDIR}"  || die

	#popd
}

pkg_postinst() {

	elog "Installation finished, you may now start using BackupPC."
	elog
	elog "- Read the documentation in /usr/share/doc/${PF}/BackupPC.html"
	elog "  Please pay special attention to the security section."
	elog
	elog "- You can launch backuppc by running:"
	elog
	elog "    # /etc/init.d/backuppc start"
	elog
	elog "- To enable the GUI, first edit ${ROOT}etc/conf.d/apache2 and add,"
	elog
	elog "    \"-D BACKUPPC -D PERL -D MPM_ITK\""
	elog
	elog "  to the APACHE2_OPTS line."
	elog
	elog "  Then you must edit ${ROOT}etc/apache2/modules.d/00_mpm_itk.conf"
	elog "  and adjust the values of LimitUIDRange/LimitGIDRange to include"
	elog "  the UID and GID of the backuppc user."
	elog
	elog "  Finally, start apache:"
	elog
	elog "    # /etc/init.d/apache2 start"
	elog
	elog "  The web interface should now be running on,"
	elog
	elog "    http://127.0.0.1:8080/"
	elog

	if use apache2 ; then
		# Generate a new password if there's no auth file
		if [[ ! -f "${CONFDIR}/users.htpasswd" ]]; then
			adminuser="backuppc"
			adminpass=$( makepasswd --chars=12 )
			htpasswd -bc "${CONFDIR}/users.htpasswd" $adminuser $adminpass

			elog ""
			elog "- Created admin user $adminuser with password $adminpass"
			elog "  To add new users, run: "
			elog ""
			elog "  # htpasswd ${CONFDIR}/users.htpasswd newUser"
		fi
	fi
	
}
