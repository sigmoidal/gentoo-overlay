# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby20 ruby21 ruby22"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC=""

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem versionator

DESCRIPTION="Ruby library for compiling and serving web assets"
HOMEPAGE="https://github.com/rails/sprockets"

LICENSE="MIT"
SLOT="$(get_version_component_range 1)"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

IUSE=""

ruby_add_rdepend "
	=dev-ruby/hike-1*:0 >=dev-ruby/hike-1.2:0
	=dev-ruby/multi_json-1*
	=dev-ruby/rack-1*:*
	=dev-ruby/tilt-1*:0 >=dev-ruby/tilt-1.3.1:0
	!!<dev-ruby/sprockets-2.2.2-r1:2.2"

ruby_add_bdepend "test? (
		dev-ruby/json
		dev-ruby/rack-test
		=dev-ruby/coffee-script-2*
		=dev-ruby/execjs-2*
		=dev-ruby/sass-3* >=dev-ruby/sass-3.1
		dev-ruby/uglifier
	)"

#all_ruby_prepare() {
#	# Require a newer version of execjs since we do not have this slotted.
#	sed -i -e '/execjs/ s/1.0/2.0/' ${RUBY_FAKEGEM_GEMSPEC} || die
#
#}

