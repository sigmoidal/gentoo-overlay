# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

USE_RUBY="ruby22 ruby23 ruby24 ruby30 ruby31"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG.md"

inherit ruby-fakegem

DESCRIPTION="Create JSON structures via a Builder-style DSL"
HOMEPAGE="https://github.com/rails/jbuilder"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

ruby_add_rdepend "
	>=dev-ruby/activesupport-3.0.0 <dev-ruby/activesupport-5.2
	>=dev-ruby/multi_json-1.2 <dev-ruby/multi_json-2.0
"