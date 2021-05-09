# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils multilib user

DESCRIPTION="Multi-platform log processor and forwarder"
HOMEPAGE="https://fluentbit.io"
SRC_URI="https://github.com/fluent/fluent-bit/archive/v${PV}.tar.gz"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

pkg_preinst() {
    ebegin "Creating fluent-bit user and group"
    enewgroup fluentbit
    enewuser fluentbit -1 -1 /dev/null fluentbit
}

src_configure() {
    local mycmakeargs=(
       -DFLB_HTTP_SERVER=On
       -DFLB_TLS=On
       # in_http is still in dev (can't compile)
       #-DFLB_IN_HTTP=On
       -DCMAKE_INSTALL_SYSCONFDIR="${EPREFIX}/etc"
    )

    cmake-utils_src_configure
}

src_install() {
    cmake-utils_src_install

    newinitd "${FILESDIR}"/fluent-bit.initd fluent-bit
    newconfd "${FILESDIR}"/fluent-bit.confd fluent-bit

    dodir /var/lib/fluent-bit
    keepdir /var/lib/fluent-bit
}
