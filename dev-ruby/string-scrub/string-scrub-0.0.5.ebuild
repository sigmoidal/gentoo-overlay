# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

USE_RUBY="ruby22 ruby23 ruby24 ruby31"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="String#scrub for Ruby 2.2.x, 2.1.x, 2.0.0 and 1.9.3"
HOMEPAGE="https://github.com/hsbt/string-scrub"

LICENSE="MIT"
SLOT="$(ver_cut 1-2)"
KEYWORDS="~amd64 ~x86"

IUSE=""

all_ruby_prepare() {
	rm -r Gemfile* || die

	sed -i -e '/[Bb]undler/d' Rakefile || die
}

each_ruby_configure() {
	${RUBY} -Cext/string extconf.rb || die
}

each_ruby_compile() {
	emake V=1 -Cext/string
	mkdir lib/string
	cp ext/string/scrub$(get_modname) lib/string/ || die
}