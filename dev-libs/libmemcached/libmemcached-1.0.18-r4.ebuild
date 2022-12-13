# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WANT_AUTOMAKE=1.16

inherit autotools multilib

RESTRICT="test" # https://bugs.gentoo.org/show_bug.cgi?id=498250 https://bugs.launchpad.net/gentoo/+bug/1278023

DESCRIPTION="a C client library to the memcached server"
HOMEPAGE="https://libmemcached.org/libMemcached.html"
SRC_URI="https://launchpad.net/${PN}/1.0/${PV}/+download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~ia64 ppc ppc64 s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="debug hsieh +libevent sasl static-libs"

DEPEND="net-misc/memcached
	sasl? ( dev-libs/cyrus-sasl )
	libevent? ( dev-libs/libevent )"
RDEPEND="${DEPEND}"

PATCHES=(
   "${FILESDIR}"/debug-disable-enable-1.0.18.patch
   "${FILESDIR}"/continuum-1.0.18.patch
   "${FILESDIR}"/${P}-gcc7.patch
   "${FILESDIR}"/${P}-autotools.patch
   "${FILESDIR}"/${P}-disable-sphinx.patch
   "${FILESDIR}"/${P}-musl.patch
   "${FILESDIR}/max_number_of_slab_classes-1.0.18.patch"
)

src_prepare() {
   eapply_user
	sed -i '6i CFLAGS = @CFLAGS@' Makefile.am
	sed -e "/_APPEND_COMPILE_FLAGS_ERROR(\[-fmudflapth\?\])/d" -i m4/ax_harden_compiler_flags.m4
	eautoreconf
}

src_configure() {
	econf \
		--disable-dtrace \
		$(use_enable static-libs static) \
		$(use_enable sasl sasl) \
		$(use_enable debug debug) \
		$(use_enable debug assert) \
		$(use_enable hsieh hsieh_hash) 
}

src_install() {
	emake DESTDIR="${D}" install

	use static-libs || rm -f "${D}"/usr/$(get_libdir)/lib*.la

	dodoc AUTHORS ChangeLog README THANKS TODO
	# remove manpage to avoid collision, see bug #299330
	rm -f "${D}"/usr/share/man/man1/memdump.*
	newman man/memdump.1 memcached_memdump.1
}
