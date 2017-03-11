# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils user

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


pkg_setup() {
   enewgroup hitch
   enewuser hitch -1 -1 -1 hitch
}

src_install() {
   newinitd "${FILESDIR}"/hitch.rc hitch

	insinto /etc/hitch
	newins "${FILESDIR}"/hitch.conf hitch.conf
}
