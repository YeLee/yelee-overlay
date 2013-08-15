# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Rime support for Fcitx"
HOMEPAGE="http://fcitx-im.org/"
SRC_URI="http://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=app-i18n/fcitx-4.2.8.1
	app-i18n/librime
	x11-libs/libnotify"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-setup-logging.patch"
	epatch "${FILESDIR}/${P}-new-stat-and-menu.patch"
	epatch "${FILESDIR}/${P}-new-notification.patch"
	epatch "${FILESDIR}/${P}-fix-invalid-sessionid.patch"
	epatch "${FILESDIR}/zh_po.patch"
	epatch_user
}

src_configure() {
	local mycmakeargs=(
		-DRIME_DATA_DIR=/usr/share/rime-data
	)
	cmake-utils_src_configure
}
