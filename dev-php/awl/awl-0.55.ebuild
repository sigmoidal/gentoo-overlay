# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit eutils git-r3

DESCRIPTION="Andrew McMillan's web libraries: A collection of generic classes
used by the davical calendar server"
HOMEPAGE="http://wiki.davical.org/"
EGIT_REPO_URI="https://gitlab.com/davical-project/awl.git"
EGIT_COMMIT="5ca35ae95c35f2ffe436ebec0fc975eae63b2bc8"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="doc? ( dev-php/PEAR-PhpDocumentor )"
RDEPEND="dev-lang/php[pdo,postgres,xml]"

DOCS="debian/README.Debian debian/changelog"

src_compile() {
	if use doc ; then
		ebegin "Generating documentation"
		phpdoc -c "docs/api/phpdoc.ini" || die "Documentation failed to build"
	fi
}

src_install() {
	use doc && dohtml -r "docs/api/"
	insinto "/usr/share/php/${PN}"
	doins -r dba inc scripts
}
