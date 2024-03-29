# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


EAPI=8

USE_RUBY="ruby22 ruby23 ruby24 ruby30 ruby31"

#RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc DOCUMENTATION.en.rdoc DOCUMENTATION.ja.rdoc README.ja README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Rexical is a lexical scanner generator"
HOMEPAGE="https://github.com/tenderlove/rexical/tree/master"
LICENSE="LGPL-2" # plus exception

KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

# File collision, bug 459116
RDEPEND+=" !!app-admin/rex"

#ruby_add_bdepend "doc? ( >=dev-ruby/hoe-2.6.2 )"

all_ruby_prepare() {
	#sed -i -e '1igem "test-unit"' test/test_generator.rb || die

	sed -i -e '/rubyforge_name/d' Rakefile || die
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc sample/* || die
}
