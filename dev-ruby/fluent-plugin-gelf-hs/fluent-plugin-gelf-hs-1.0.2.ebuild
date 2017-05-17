# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
USE_RUBY="ruby22 ruby23 ruby24"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="fluent-plugin-gelf-hs.gemspec"

inherit ruby-fakegem versionator

DESCRIPTION="Buffered fluentd output plugin to GELF (Graylog2)."
HOMEPAGE="https://github.com/bodhi-space/fluent-plugin-gelf-hs"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE=""

ruby_add_rdepend "dev-ruby/fluentd
>=dev-ruby/gelf-2.0.0"

all_ruby_prepare() {
	rm -r Gemfile* .gitignore || die
	sed -i -e '/git ls-files/d' ${RUBY_FAKEGEM_GEMSPEC} || die
}