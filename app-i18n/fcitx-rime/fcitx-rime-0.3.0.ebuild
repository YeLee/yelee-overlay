# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils gnome2-utils

TREE_VER="19ad5e49c773c781d3f01351667596cb8ff62930"
DESCRIPTION="Rime support for Fcitx"
HOMEPAGE="http://fcitx-im.org/"
SRC_URI="https://codeload.github.com/fcitx/fcitx-rime/zip/${TREE_VER} -> ${P}.zip"
S=${WORKDIR}/${PN}-${TREE_VER}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.8.1
	x11-libs/libnotify
	|| (
		>=app-i18n/librime-1.0.0[minimal]
		>=app-i18n/rime-data-0.30
		)"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.3.0-fix-ui-icon.patch"
	epatch_user
}

src_configure() {
	local mycmakeargs=(
		-DRIME_DATA_DIR=/usr/share/rime-data
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
