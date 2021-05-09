# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PHP_EXT_NAME="rdkafka"
PHP_EXT_INIT="yes"
PHP_EXT_ZENDEXT="no"
DOCS=( CREDITS )

USE_PHP="php7-3 php7-4"

inherit php-ext-pecl-r3

DESCRIPTION="A wrapper around rdkafka"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/librdkafka"
RDEPEND="${DEPEND}"
PHP_EXT_ECONF_ARGS=()
