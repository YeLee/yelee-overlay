# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils multilib eutils

TREE_VER="7fdaa43f1c548cc53ab9c7b59a697851060f4f46"
DESCRIPTION="Libraries for conversion between Traditional and Simplified Chinese."
HOMEPAGE="https://github.com/BYVoid/OpenCC"
SRC_URI="https://codeload.github.com/BYVoid/OpenCC/zip/${TREE_VER} -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+nls static-libs"
RESTRICT="mirror"

DEPEND=""
RDEPEND=""

DOCS="AUTHORS LICENSE NEWS.md README.md"
S=${WORKDIR}/OpenCC-${TREE_VER}

src_prepare() {
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
