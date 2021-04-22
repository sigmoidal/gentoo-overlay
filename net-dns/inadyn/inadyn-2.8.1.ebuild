# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils git-r3

DESCRIPTION="Dyndns client in C supporting various services"
HOMEPAGE="http://troglobit.com/inadyn.html"

EGIT_REPO_URI="https://github.com/troglobit/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+ssl libressl"

DEPEND="dev-libs/libite
	dev-libs/confuse
	ssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:= )
	)
"

RDEPEND=""

#S="${WORKDIR}/src"

#pkg_setup() {
#enewuser inadyn -1 -1 -1
#}

src_prepare() {
	#eapply_user
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable ssl openssl)
}

#src_prepare() {
#  rm -R bin || die
#  cp "${FILESDIR}"/${P}-makefile src/Makefile || die
#}

src_compile() {
#  cd src || die
	emake || die
}

src_install() {
	dosbin src/inadyn || die
	doman man/${PN}* || die

#  newinitd "${FILESDIR}"/inadyn.initd inadyn || die

	insinto /etc/${PN}
#  doins "${FILESDIR}"/inadyn.conf || die
	doins examples/* || die
}

pkg_postinst() {
	elog "You will need to edit /etc/inadyn.conf file before"
	elog "running inadyn for the first time. The file is basically"
	elog "command line options; see inadyn and inayn.conf manpages."
}
