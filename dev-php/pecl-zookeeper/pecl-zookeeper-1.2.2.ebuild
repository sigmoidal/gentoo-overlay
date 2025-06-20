# Copyright 1999-2023 sigmoidal
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="zookeeper"
PHP_EXT_INIT="yes"
PHP_EXT_ZENDEXT="no"
DOCS=( CREDITS )

USE_PHP="php7-3 php7-4 php8-0 php8-1 php8-2 php8-3"

inherit php-ext-pecl-r3

DESCRIPTION="PHP extension for interfacing with Apache ZooKeeper"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/zookeeper-c"
RDEPEND="${DEPEND}"
PHP_EXT_ECONF_ARGS=()
