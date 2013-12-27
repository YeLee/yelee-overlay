# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vcs-snapshot

TREE_VER="fde8728e6c73d6b72e444aba921b932ebcbeadd6"
DESCRIPTION="Data resources for Rime Input Method Engine"
HOMEPAGE="http://code.google.com/p/rimeime/"
SRC_URI="https://codeload.github.com/lotem/brise/zip/${TREE_VER} -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="( >=app-i18n/librime-1.0.0[-minimal] )"
RDEPEND="${DEPEND}"
S=${WORKDIR}/brise-${TREE_VER}
