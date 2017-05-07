# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
USE_RUBY="ruby21 ruby22"

RUBY_FAKEGEM_BINWRAP="fluentd-ui"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

RUBY_FAKEGEM_EXTRADOC="README.md ChangeLog"

inherit user eutils ruby-fakegem versionator

DESCRIPTION="Web UI for Fluentd"
HOMEPAGE="https://github.com/fluent/fluentd-ui"
SRC_URI="https://github.com/fluent/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	dev-ruby/addressable
	dev-ruby/bundler
	dev-ruby/diff-lcs
	>=dev-ruby/draper-1.3 <dev-ruby/draper-2.0
	>=app-admin/fluentd-0.10.56 <app-admin/fluentd-2.0
	dev-ruby/font-awesome-rails
	>=dev-ruby/haml-rails-0.5.3 <dev-ruby/haml-rails-0.6
	>=dev-ruby/httpclient-2.5 <dev-ruby/httpclient-3.0
	>=dev-ruby/jbuilder-2.0 <dev-ruby/jbuilder-3.0
	>=dev-ruby/jquery-rails-3.1.0 <dev-ruby/jquery-rails-3.2
	>dev-ruby/kramdown-1.0.0
	dev-ruby/kramdown-haml
	>=dev-ruby/rails-4.2 <dev-ruby/rails-4.3
	>=dev-ruby/rubyzip-1.1 <dev-ruby/rubyzip-2.0
	>=dev-ruby/sass-rails-4.0.3:4.0 <dev-ruby/sass-rails-4.1:4.0
	dev-ruby/settingslogic
	>=dev-ruby/sucker_punch-1.0.5 <dev-ruby/sucker_punch-1.1
	dev-ruby/thor"

RDEPEND+="
	>=app-admin/fluentd-0.10.56 <app-admin/fluentd-2.0 
	www-servers/puma"

pkg_setup() {
	enewgroup fluentd
	enewuser fluentd -1 -1 -1 fluentd
}

#src_prepare() {
#ruby-ng_src_unpack
#}

#src_compile() {
#   default_src_compile
#   ruby-ng_src_compile
#}
#   

all_ruby_install() {
	einfo "WTF!!! each_ruby_install"
#	cd "marionette-collective-${PV}"
#	doruby -r lib/*
#}
#

#src_install() {
#	elog "${PN} =>>> src_install"
#
#   keepdir /etc/grafana
#   insinto /etc/grafana
#   newins "${S}"/conf/sample.ini grafana.ini
#   rm "${S}"/conf/sample.ini || die
#
   # Frontend assets
   ##insinto /usr/share/${MY_PN}
   ##doins -r public conf vendor

   ##dobin bin/fluentd-ui
	

#   newconfd "${FILESDIR}"/grafana.confd grafana
#   newinitd "${FILESDIR}"/grafana.initd.3 grafana
#   systemd_newunit "${FILESDIR}"/grafana.service grafana.service
#
#   keepdir /var/{lib,log}/fluentd-ui
   #keepdir /var/lib/fluentd-ui/{dashboards,plugins}
   
#   fowners grafana:grafana /var/{lib,log}/grafana
#   fowners grafana:grafana /var/lib/grafana/{dashboards,plugins}
#   fperms 0750 /var/{lib,log}/grafana
#   fperms 0750 /var/lib/grafana/{dashboards,plugins}
}

postinst() {
   elog "${PN} message"
}



#all_ruby_prepare() {
#	rm Gemfile || die
#	sed -i -e '/bundler/,/^end/ s:^:#:' spec/spec_helper.rb || die
#	sed -i -e '/bundler/,/^end/ s:^:#:' Rakefile || die
#}
#
#each_ruby_install() {
#	each_fakegem_install
#	ruby_fakegem_doins Gemfile.production
#	ruby_fakegem_doins config.ru
#	ruby_fakegem_doins -r app
#	ruby_fakegem_doins -r config
#	ruby_fakegem_doins -r public
#}
#
#all_ruby_install() {
#   all_fakegem_install
#}
