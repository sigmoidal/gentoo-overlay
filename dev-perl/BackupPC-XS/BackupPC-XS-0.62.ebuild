# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=CBARRATT
DIST_VERSION=0.62

inherit perl-module

DESCRIPTION="BackupPC::XS implements various BackupPC functions in a perl-callable module."
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="net-misc/rsync-bpc"
DEPEND="${RDEPEND}
	dev-perl/Module-Build
	test? ( dev-perl/Test-Fatal
	virtual/perl-Test-Simple )
"

src_test() {
	perl-module_src_test
}
