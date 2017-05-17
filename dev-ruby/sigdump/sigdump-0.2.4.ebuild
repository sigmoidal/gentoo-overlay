# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

USE_RUBY="ruby22 ruby23 ruby24"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md ChangeLog"

inherit ruby-fakegem versionator

DESCRIPTION="SIGQUIT of Java VM for Ruby: installs a signal handler which dumps backtrace of running threads and number of allocated objects per class"
HOMEPAGE="https://github.com/frsyuki/sigdump"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

