
EAPI=8

inherit flag-o-matic
inherit autotools

DESCRIPTION="C client interface to Zookeeper server"
HOMEPAGE="https://zookeeper.apache.org/"

SRC_URI="https://archive.apache.org/dist/zookeeper/zookeeper-${PV}/apache-zookeeper-${PV}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc static-libs test"


RDEPEND=""
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	test? ( dev-util/cppunit )"

S="${WORKDIR}/apache-zookeeper-${PV}/zookeeper-client/zookeeper-client-c"

src_prepare() {

   default

   #
   # maybe the following can be done in pkg_setup() ?
   #
   # these need to be generated from the apache zookeeper release
   # because in portage maven (mvn) cannot connect out while building :(
   #
   # 1. Install maven if you haven't: emerge -Dva dev-java/maven-bin
   # 2. Download Apache ZooKeeper vX.X.X Source Release from Apache (not from git)
   #    https://zookeeper.apache.org/releases.html
   # 3. tar xvfz apache-zookeeper-X.X.X.tar.gz
   # 4. cd apache-zookeeper-X.X.X && mvn -pl zookeeper-jute compile
   # 5. copy the generated: generated/zookeeper.jute.* under the files/ portage dir
   #

   mkdir -p "${S}/generated"
   cp "${FILESDIR}/zookeeper-${PV}.jute.h"  "${S}/generated/zookeeper.jute.h"
   cp "${FILESDIR}/zookeeper-${PV}.jute.c"  "${S}/generated/zookeeper.jute.c"

   eautoreconf -iv
}

src_configure() {
   append-flags -Wno-nonnull
   append-flags -Wno-format-overflow

   econf \
      $(use_enable static-libs static) \
      $(use_with test cppunit)

   #econf \
   #   --disable-shared \
   #   --without-cppunit
}

src_compile() {
   emake
   use doc && emake doxygen-doc
}

src_install() {
   default
   use doc && dohtml docs/html/*

   if ! use static-libs; then
      find "${D}" -name '*.la' -delete || die
   fi
}
