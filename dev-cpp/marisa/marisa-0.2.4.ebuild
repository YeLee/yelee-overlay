# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit multilib-minimal

DESCRIPTION="Matching Algorithm with Recursively Implemented StorAge"
HOMEPAGE="https://code.google.com/p/marisa-trie/"
SRC_URI="https://marisa-trie.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

multilib_src_configure() {
	ECONF_SOURCE=${S} econf $(use_enable static-libs static)
}

multilib_src_install_all() {
	dodoc AUTHORS README COPYING
	dohtml docs/*
}
