# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
USE_RUBY="ruby22 ruby23 ruby24"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG VERSION"

inherit ruby-fakegem versionator

DESCRIPTION="Library to send GELF messages to Graylog logging server"
HOMEPAGE="https://github.com/graylog-labs/gelf-rb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE=""

ruby_add_rdepend ">=dev-ruby/json-2.0.0"

all_ruby_prepare() {
	rm -r Gemfile* || die

	sed -i -e '/[Bb]undler/d' Rakefile || die
}