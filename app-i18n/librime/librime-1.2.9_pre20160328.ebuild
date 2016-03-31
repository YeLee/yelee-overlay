# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils multilib versionator toolchain-funcs

TREE_VER="1da0c637d98c6381f755b24d15bb2ec358246348"
DESCRIPTION="Rime Input Method Engine - the core library"
HOMEPAGE="https://bintray.com/lotem/rime/librime"
SRC_URI="https://codeload.github.com/lotem/librime/zip/${TREE_VER} -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs minimal test +glog"
RESTRICT="mirror"
S=${WORKDIR}/${PN}-${TREE_VER}

RDEPEND=">=app-i18n/opencc-1.0.1-r1
	glog? ( dev-cpp/glog )
	>=dev-cpp/yaml-cpp-0.5.0
	dev-db/kyotocabinet
	>=dev-libs/boost-1.46.0[threads(+)]
	dev-libs/leveldb
	dev-libs/marisa
	sys-libs/zlib
	x11-proto/xproto"
DEPEND="${RDEPEND}
	minimal? ( !app-i18n/rime-data )
	test? ( dev-cpp/gtest )"

pkg_pretend() {
	if [ ${MERGE_TYPE} != binary ]; then
		version_is_at_least 4.8.0 "$(gcc-fullversion)" \
			|| die "Sorry, but gcc-4.8.0 and earlier wont work for librime (see bug 496080)."
	fi
}

src_prepare() {
	epatch_user
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build static-libs STATIC)
		-DBUILD_DATA=OFF
		-DBUILD_SEPARATE_LIBS=OFF
		-DBOOST_USE_CXX11=OFF
		$(cmake-utils_use_build test TEST)
		$(cmake-utils_use_enable glog LOGGING)
		-DLIB_INSTALL_DIR=/usr/$(get_libdir)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use minimal ; then
		${BUILD_DIR}/bin/rime_deployer --build ${BUILD_DIR}/bin || die
	fi
}

src_install() {
	if use minimal ; then
		insinto /usr/share/rime-data
		doins ${BUILD_DIR}/bin/*.yaml || die
		doins ${BUILD_DIR}/bin/*.bin || die
		doins ${BUILD_DIR}/bin/essay.txt || die
	fi
	cmake-utils_src_install
}

