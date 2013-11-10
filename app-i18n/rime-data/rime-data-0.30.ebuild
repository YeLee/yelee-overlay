# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vcs-snapshot

TREE_VER="468351dbc076a03ca5c2ee520e8fbe0dafc0d3e7"
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
