# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic toolchain-funcs

if [[ ${PV} == 9999* ]]; then
   EGIT_REPO_URI="https://github.com/uoaerg/${PN}.git"
   inherit git-r3
else
   SRC_URI="https://github.com/uoaerg/${PN}/archive/v${PV}.tar.gz"
   KEYWORDS="amd64 x86"
fi

DESCRIPTION="wavemon is an ncurses-based monitoring application for wireless network devices"
HOMEPAGE="https://github.com/uoaerg/wavemon"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm hppa ppc sparc x86"

IUSE="caps"
RDEPEND="sys-libs/ncurses
   >=dev-libs/libnl-3.2
	caps? ( sys-libs/libcap )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README.md THANKS )
PATCHES=(
	"${FILESDIR}/${PN}-0.6.7-dont-override-CFLAGS.patch"
	"${FILESDIR}/${P}-ncurses-tinfo.patch"
)

src_prepare() {
	default

	# Do not install docs to /usr/share
	sed -i -e '/^install:/s/install-docs//' Makefile.in || die 'sed on Makefile.in failed'
	sed -i -r -e 's/^CFLAGS\s+\?=\s+@CFLAGS@ @LIBNL3_CFLAGS@/CFLAGS\t = @CFLAGS@ @LIBNL3_CFLAGS@/' Makefile.in || die 'sed on Makefile.in failed'
	sed -i -r -e 's/^CPPFLAGS\s+\?= @CPPFLAGS@/CPPFLAGS = @CPPFLAGS@ @LIBNL3_CFLAGS@/' Makefile.in || die 'sed on Makefile.in failed'

	# automagic on libcap, discovered in bug #448406
	use caps || export ac_cv_lib_cap_cap_get_flag=false

	eautoreconf
}

src_install() {
	default
	#autotools-utils_src_install
	# Install man files manually(bug #397807)
	doman wavemon.1
	doman wavemonrc.5
}
