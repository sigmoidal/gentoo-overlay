# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

#inherit eutils

DESCRIPTION="A libev-based high performance SSL/TLS proxy"
HOMEPAGE="https://hitch-tls.org/"
SRC_URI="https://hitch-tls.org/source/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="dev-libs/openssl:0
		>=dev-libs/libev-4"
RDEPEND="${DEPEND}"

HUSER=hitch
HGROUP=hitch

pkg_setup() {
	enewgroup ${HGROUP}
	enewuser ${HUSER} -1 -1 -1 ${HGROUP}
}

src_install() {
	newinitd "${FILESDIR}"/hitch.rc hitch

	insinto /etc/hitch
	newins "${FILESDIR}"/hitch.conf hitch.conf

	dosbin "src/${PN}"

	keepdir /var/lib/${PN}
	fowners ${HUSER}:${HGROUP} /var/lib/${PN}
	fperms 750 /var/lib/${PN}
}
