# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
USE_RUBY="ruby21 ruby22"

RUBY_FAKEGEM_BINWRAP="fluentd-ui"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md ChangeLog"

inherit ruby-fakegem versionator

DESCRIPTION="Web UI for Fluentd"
HOMEPAGE="https://github.com/fluent/fluentd-ui"

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

all_ruby_install() {
   all_fakegem_install
}
