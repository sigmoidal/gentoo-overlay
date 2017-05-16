# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
USE_RUBY="ruby22 ruby23 ruby24"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG.md"

inherit ruby-fakegem versionator

DESCRIPTION="Draper adds an object-oriented layer of presentation logic to your Rails apps."
HOMEPAGE="http://github.com/drapergem/draper"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND+="
	>=dev-ruby/actionpack-3.0
	>=dev-ruby/activemodel-3.0
	>=dev-ruby/activesupport-3.0
	>=dev-ruby/request_store-1.0 <dev-ruby/request_store-2.0"
