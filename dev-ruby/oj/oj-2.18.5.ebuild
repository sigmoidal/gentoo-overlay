# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

USE_RUBY="ruby22 ruby23 ruby24 ruby25"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem versionator

DESCRIPTION="A fast JSON parser and Object marshaller as a Ruby gem."
HOMEPAGE="https://github.com/ohler55/oj"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE=""


each_ruby_configure() {
	${RUBY} -Cext/oj extconf.rb || die
}


each_ruby_compile() {
	emake V=1 -Cext/oj
	cp ext/oj/oj$(get_modname) lib/oj/ || die
}