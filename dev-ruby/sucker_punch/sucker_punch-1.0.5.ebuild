# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

USE_RUBY="ruby22 ruby23 ruby24 ruby31"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md CHANGES.md"

inherit ruby-fakegem

DESCRIPTION="Asynchronous processing library for Ruby"
HOMEPAGE="https://github.com/brandonhilkert/sucker_punch"

LICENSE="MIT"
SLOT="$(ver_cut 1-2)"
KEYWORDS="~amd64 ~x86"

IUSE=""

ruby_add_rdepend ">=dev-ruby/celluloid-0.15.2 <dev-ruby/celluloid-0.16"

