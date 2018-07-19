# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PHP_EXT_NAME="zookeeper"
PHP_EXT_INIT="yes"
PHP_EXT_ZENDEXT="no"
DOCS=( CREDITS )

USE_PHP="php5-6 php7-0 php7-1 php7-2"

inherit php-ext-pecl-r3

DESCRIPTION="PHP extension for interfacing with Apache ZooKeeper"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/zookeeper-c"
RDEPEND="${DEPEND}"
PHP_EXT_ECONF_ARGS=()
