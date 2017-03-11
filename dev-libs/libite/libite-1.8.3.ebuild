# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools eutils

DESCRIPTION="Libite is a lightweight library that holds useful functions and macros."
HOMEPAGE="https://github.com/troglobit/libite"
SRC_URI="https://github.com/troglobit/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT BSD ISC"
SLOT="0"
KEYWORDS="amd64 x86"
#IUSE="debug examples static-libs"

RDEPEND=""
DEPEND="${RDEPEND}"

#DOCS=( AUTHORS NEWS README )

src_prepare() {
	default_src_prepare
	eautoreconf
}

#src_configure() {
#
#	econf --disable-hardening \
#		--disable-optimizations \
#		$(use_enable debug) \
#		$(use_enable static-libs static)
#}

#src_install() {
#	default_src_install
#	if [[ -f "${D}usr/share/doc/${P}/COPYING" ]] ; then
#		rm "${D}usr/share/doc/${P}/COPYING" || die
#	fi
#	# Installing all the manuals conflicts with man-pages
#	doman doc/man/bson_*.3
#	use static-libs || find "${D}" -name '*.la' -delete
#
#	if use examples; then
#		insinto /usr/share/${PF}/examples
#		doins examples/*.c
#	fi
#}
