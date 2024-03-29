# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="zookeeper"
PHP_EXT_INIT="yes"
PHP_EXT_ZENDEXT="no"
DOCS=( CREDITS )

USE_PHP="php7-3 php7-4"

inherit php-ext-pecl-r3

DESCRIPTION="PHP extension for interfacing with Apache ZooKeeper"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/zookeeper-c"
RDEPEND="${DEPEND}"
PHP_EXT_ECONF_ARGS=()
