# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils flag-o-matic prefix

DESCRIPTION="rsync version needed for BackupPC 4.x"
HOMEPAGE="https://github.com/backuppc/rsync-bpc"
SRC_URI="https://github.com/backuppc/rsync-bpc/releases/download/v3_0_9_6/rsync-bpc-3.0.9.6.tar.gz"

LICENSE="GPL-3"
SLOT="0"
if [[ ${PV} != *_pre ]] ; then
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x64-cygwin ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
fi
IUSE="acl iconv ipv6 static stunnel xattr"

LIB_DEPEND="acl? ( virtual/acl[static-libs(+)] )
	xattr? ( kernel_linux? ( sys-apps/attr[static-libs(+)] ) )
	>=dev-libs/popt-1.5[static-libs(+)]"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	iconv? ( virtual/libiconv )"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )"

S=${WORKDIR}/${P/_/}

src_prepare() {
	epatch_user
}

src_configure() {
	use static && append-ldflags -static
	econf \
		--without-included-popt \
		$(use_enable acl acl-support) \
		$(use_enable xattr xattr-support) \
		$(use_enable ipv6) \
		$(use_enable iconv) \
		--with-rsyncd-conf="${EPREFIX}"/etc/rsyncd.conf
	touch proto.h-tstamp #421625
}

src_install() {
	emake DESTDIR="${D}" install

	# Install stunnel helpers
	if use stunnel ; then
		emake DESTDIR="${D}" install-ssl-client
		emake DESTDIR="${D}" install-ssl-daemon
	fi

	# Install the useful contrib scripts
	exeinto /usr/share/rsync-bpc
	doexe support/*
	rm -f "${ED}"/usr/share/rsync-bpc/{Makefile*,*.c}

	#systemd_dounit "${FILESDIR}/rsyncd.service"
}

pkg_postinst() {
	if use stunnel ; then
		einfo "Please install \">=net-misc/stunnel-4\" in order to use stunnel feature."
		einfo
		einfo "You maybe have to update the certificates configured in"
		einfo "${EROOT}/etc/stunnel/rsync.conf"
	fi
}
