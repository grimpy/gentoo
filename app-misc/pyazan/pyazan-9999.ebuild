# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

DESCRIPTION="PyAzan Prayer notifier."
EGIT_REPO_URI="git://github.com/grimpy/pyazan.git"
EGIT_PROJECT="master"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/notify-python
        dev-python/pygtk"
RDEPEND="${DEPEND}"
