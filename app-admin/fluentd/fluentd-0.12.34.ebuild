# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Obtained from: https://github.com/mazgi/portage-overlay/tree/master/app-admin/fluentd

EAPI=5
USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_BINWRAP="fluentd fluent-cat fluent-debug fluent-gem"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md AUTHORS CONTRIBUTING.md COPYING ChangeLog"
RUBY_FAKEGEM_EXTRAINSTALL="fluent.conf"

inherit ruby-fakegem user versionator

DESCRIPTION="Fluentd is an open source data collector for unified logging layer."
HOMEPAGE="http://www.fluentd.org"

LICENSE="Apache-2.0"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"

IUSE=""

ruby_add_rdepend "
	>=dev-ruby/coolio-1.2.2 <dev-ruby/coolio-2.0.0
	>=dev-ruby/http_parser_rb-0.5.1 <dev-ruby/http_parser_rb-0.7.0
	>=dev-ruby/json-1.4.3
	>=dev-ruby/msgpack-0.5.11 <dev-ruby/msgpack-0.6.0
	~dev-ruby/sigdump-0.2.2
	>=dev-ruby/tzinfo-1.0.0
	>=dev-ruby/tzinfo-data-1.0.0
	=dev-ruby/yajl-ruby-1*"

RDEPEND="${RDEPEND}
	ruby_targets_ruby19? (
		>=dev-ruby/string-scrub-0.0.3 <=dev-ruby/string-scrub-0.0.5
	)
	ruby_targets_ruby20? (
		>=dev-ruby/string-scrub-0.0.3 <=dev-ruby/string-scrub-0.0.5
	)"

pkg_setup() {
	enewgroup fluentd
	enewuser fluentd -1 -1 -1 fluentd
}

all_ruby_install() {
	all_fakegem_install

	keepdir "/var/log/${PN}"
	keepdir "/etc/${PN}"
	fowners fluentd:fluentd "/var/log/${PN}"

	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
}

pkg_postinst() {
	ewarn "Run \`fluentd --setup /etc/fluentd\` to create Fluentd config."
}
