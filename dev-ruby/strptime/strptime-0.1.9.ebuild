# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
USE_RUBY="ruby20 ruby21 ruby22"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem versionator

DESCRIPTION="a fast strptime engine which uses VM."
HOMEPAGE="https://github.com/nurse/strptime"

LICENSE="BSD-2-CLAUSE"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

all_ruby_prepare() {
	rm -r Gemfile* || die

	sed -i -e '/[Bb]undler/d' Rakefile || die
}
	
each_ruby_configure() {
	${RUBY} -Cext/strptime extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/strptime
	cp ext/strptime/strptime$(get_modname) lib/strptime/ || die
}