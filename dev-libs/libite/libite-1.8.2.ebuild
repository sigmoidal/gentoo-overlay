# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit autotools

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
