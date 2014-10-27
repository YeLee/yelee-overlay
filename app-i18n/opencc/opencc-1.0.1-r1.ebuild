# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils multilib eutils

DESCRIPTION="Libraries for conversion between Traditional and Simplified Chinese."
HOMEPAGE="https://github.com/BYVoid/OpenCC"
SRC_URI="http://dl.bintray.com/byvoid/opencc/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+nls static-libs"
RESTRICT="mirror"

DEPEND=""
RDEPEND=""

DOCS="AUTHORS LICENSE NEWS.md README.md"

src_prepare() {
	epatch "${FILESDIR}/${PN}-${PVR}.patch"
	epatch_user
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}"/usr/$(get_libdir)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	use static-libs || find "${ED}" -name '*.la' -o -name '*.a' -exec rm {} +
}
