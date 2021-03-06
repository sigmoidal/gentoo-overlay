# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
# rbx or jruby recommended, but only in 1.9 mode.
USE_RUBY="ruby22 ruby23 ruby24"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
#Needed by dev-ruby/listen
RUBY_FAKEGEM_EXTRAINSTALL="spec"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Provides a simple and natural way to build fault-tolerant concurrent programs"
HOMEPAGE="https://github.com/celluloid/celluloid"
SRC_URI="https://github.com/celluloid/celluloid/archive/v${PV}.tar.gz -> ${P}-git.tgz"
IUSE=""
SLOT="0"

LICENSE="MIT"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

#RUBY_PATCHES=( "${P}-call-private-methods.patch" )

ruby_add_rdepend ">=dev-ruby/timers-1.1.0:1"

all_ruby_prepare() {
	rm Gemfile .rspec || die

	sed -i -e '/[Bb]undler/d' -e '/coveralls/I s:^:#:' spec/spec_helper.rb || die

	# Force loading of the correct timers slot to avoid a bundler dependency.
	#sed -i -e '3igem "timers", "~>1.1"' spec/spec_helper.rb || die
	sed -i -e '3irequire "timers"' spec/spec_helper.rb || die

	# Adjust timers dependency to match our slots, bug 563018
	#sed -i -e '/timers/ s/4.0.0/4.0/' ${RUBY_FAKEGEM_GEMSPEC} || die
}
