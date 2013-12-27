# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils multilib

TREE_VER="24938f623dca85a4b1aa00751bebfb2637ae53b2"
DESCRIPTION="Rime Input Method Engine library"
HOMEPAGE="http://code.google.com/p/rimeime/"
SRC_URI="https://codeload.github.com/lotem/librime/zip/${TREE_VER} -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs minimal"
S=${WORKDIR}/${PN}-${TREE_VER}

RDEPEND="app-i18n/opencc
	dev-cpp/glog
	>=dev-cpp/yaml-cpp-0.5.0
	dev-db/kyotocabinet
	>=dev-libs/boost-1.46.0[threads(+)]
	sys-libs/zlib
	x11-proto/xproto"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.8.0
	minimal? ( !app-i18n/rime-data )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.1.0-boost_build_fix.patch"
	epatch_user
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build static-libs STATIC)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use minimal ; then
		${BUILD_DIR}/bin/rime_deployer --build ${S}/data/minimal || die
	fi
}

src_install() {
	if use minimal ; then
		insinto /usr/share/rime-data
		doins ${S}/data/minimal/* || die
	fi
	cmake-utils_src_install
}
