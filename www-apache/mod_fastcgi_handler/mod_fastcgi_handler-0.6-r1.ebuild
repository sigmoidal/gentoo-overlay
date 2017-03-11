# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

GITHUB_AUTHOR="Gandi"
GITHUB_PROJECT="mod_fastcgi_handler"
#GITHUB_COMMIT="804a83e"


inherit apache-module
inherit git-r3

DESCRIPTION="A simple FastCGI handler module"
HOMEPAGE="https://github.com/Gandi/mod_fastcgi_handler"
#SRC_URI="https://nodeload.github.com/${GITHUB_AUTHOR}/${GITHUB_PROJECT}/tarball/v${PV} -> ${P}.tar.gz"

EGIT_REPO_URI="https://github.com/Gandi/mod_fastcgi_handler.git"
EGIT_BRANCH="gandi"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

#S="${WORKDIR}"/${GITHUB_AUTHOR}-${GITHUB_PROJECT}

APACHE2_MOD_CONF="20_${PN}"
APACHE2_MOD_DEFINE="FASTCGI_HANDLER"

APXS2_ARGS="-o ${PN}.so -c *.c"

need_apache2
