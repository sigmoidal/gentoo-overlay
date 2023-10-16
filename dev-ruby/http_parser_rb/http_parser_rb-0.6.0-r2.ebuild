# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby22 ruby23 ruby24 ruby30 ruby31"

RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_NAME="http_parser.rb"

inherit ruby-fakegem

DESCRIPTION="Simple callback-based HTTP request/response parser"
HOMEPAGE="https://github.com/tmm1/http_parser.rb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/json-2.0.0"

each_ruby_configure() {
	${RUBY} -Cext/ruby_http_parser extconf.rb || die
}

each_ruby_compile() {
	emake -Cext/ruby_http_parser V=1
	cp ext/ruby_http_parser/ruby_http_parser.so lib/ || die
}
