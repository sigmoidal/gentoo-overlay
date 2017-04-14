# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
USE_RUBY="ruby21 ruby22"

RUBY_FAKEGEM_BINWRAP=""

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="README.md ChangeLog"

inherit ruby-fakegem versionator

DESCRIPTION="Web UI for Fluentd"
HOMEPAGE="https://github.com/fluent/fluentd-ui"

LICENSE="Apache-2.0"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"

IUSE=""

ruby_add_rdepend "
dev-ruby/addressable
dev-ruby/bundler
dev-ruby/diff-lcs
>=app-admin/fluentd-0.10.56 <app-admin/fluentd-2.0
dev-ruby/font-awesome-rails
dev-ruby/haml-rails
dev-ruby/httpclient
~dev-ruby/jquery-rails-3.1.0
>dev-ruby/kramdown-1.0.0
www-servers/puma
~dev-ruby/rails-4.2
~dev-ruby/rubyzip-1
~dev-ruby/sass-rails-4.0
dev-ruby/settingslogic
dev-ruby/thor"

RDEPEND="${RDEPEND}"
