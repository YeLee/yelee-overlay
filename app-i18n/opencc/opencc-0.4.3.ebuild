# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils multilib eutils

DESCRIPTION="Libraries for conversion between Traditional and Simplified
Chinese."
HOMEPAGE="http://code.google.com/p/opencc/"
SRC_URI="https://github.com/BYVoid/OpenCC/archive/ver.${PV}.tar.gz ->
${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+nls static-libs"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"
RESTRICT="mirror"

src_unpack() {
	unpack ${A}
	mv -v ${WORKDIR}/OpenCC-ver.${PV} ${S} || die
}

src_prepare() {
	sed -i \
		-e "s:\${CMAKE_\(SHARED\|STATIC\)_LIBRARY_PREFIX}:\"$(get_libdir)\":" \
		 -e "s:\${CMAKE_INSTALL_LIBDIR}:\${DIR_PREFIX}/\${CMAKE_INSTALL_LIBDIR}:" \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		"$(cmake-utils_use_enable nls GETTEXT)"
	)

	cmake-utils_src_configure
}

src_install() {
	newdoc NEWS.md ChangeLog
	newdoc README.md README
	dodoc AUTHORS
	cmake-utils_src_install

	use static-libs || find "${ED}" -name '*.la' -o -name '*.a' -exec rm {} +
}
