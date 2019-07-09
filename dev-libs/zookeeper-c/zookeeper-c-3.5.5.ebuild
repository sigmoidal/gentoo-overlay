# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic
inherit autotools

DESCRIPTION="C client interface to Zookeeper server"
HOMEPAGE="https://zookeeper.apache.org/"
SRC_URI="mirror://apache/zookeeper/zookeeper-${PV}/apache-zookeeper-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc static-libs test"

RDEPEND=""
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	test? ( dev-util/cppunit )"

S="${WORKDIR}/apache-zookeeper-${PV}/zookeeper-client/zookeeper-client-c"

src_prepare() {
   default
   eautoreconf
}

src_configure() {
   append-flags -Wno-nonnull
   append-flags -Wno-format-overflow

	econf \
		$(use_enable static-libs static) \
		$(use_with test cppunit)
}

src_compile() {
	emake
	use doc && emake doxygen-doc
}

src_install() {
	default
	use doc && dohtml docs/html/*

	if ! use static-libs; then
		find "${D}" -name '*.la' -delete || die
	fi
}
