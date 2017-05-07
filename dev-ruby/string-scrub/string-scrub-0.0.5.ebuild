# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem versionator

DESCRIPTION="String#scrub for Ruby 2.2.x, 2.1.x, 2.0.0 and 1.9.3"
HOMEPAGE="https://github.com/hsbt/string-scrub"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"

IUSE=""

