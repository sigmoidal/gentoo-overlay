# Copyright 2020 sigmoid
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MODULE_AUTHOR="MJD"
MODULE_VERSION="0.12"

inherit perl-module

DESCRIPTION="Print out each line before it is executed (like C<sh -x>)"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl"
