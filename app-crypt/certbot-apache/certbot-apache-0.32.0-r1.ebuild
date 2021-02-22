# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=(python3_{4,5,6,7})

if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="https://github.com/certbot/certbot.git"
	inherit git-r3
	S=${WORKDIR}/${P}/${PN}
else
	SRC_URI="https://github.com/${PN%-apache}/${PN%-apache}/archive/v${PV}.tar.gz -> ${PN%-apache}-${PV}.tar.gz"
	KEYWORDS="amd64 ~x86"
	S=${WORKDIR}/${PN%-apache}-${PV}/${PN}
fi

inherit distutils-r1

DESCRIPTION="Apache plugin for certbot (Let's Encrypt Client)"
HOMEPAGE="https://github.com/certbot/certbot https://letsencrypt.org/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="test"

RDEPEND=">=app-crypt/certbot-0.32.0[${PYTHON_USEDEP}]
	>=app-crypt/acme-0.32.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/python-augeas[${PYTHON_USEDEP}]
	dev-python/zope-component[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]"
DEPEND="test? ( ${RDEPEND}
	dev-python/nose[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
   eapply -p1 "${FILESDIR}/override_gentoo-apache2ctl.patch"
   #eapply -p1 "${FILESDIR}/configurator-special-cases.patch"
   eapply_user
}

python_test() {
	nosetests || die
}
