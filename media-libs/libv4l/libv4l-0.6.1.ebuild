# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libv4l/libv4l-0.6.0.ebuild,v 1.1 2009/07/17 08:33:39 aballier Exp $

inherit multilib toolchain-funcs

DESCRIPTION="V4L userspace libraries"
HOMEPAGE="http://people.atrpms.net/~hdegoede/
	http://hansdegoede.livejournal.com/3636.html"
SRC_URI="http://people.atrpms.net/~hdegoede/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE="multilib"

src_compile() {
	if use multilib && use amd64; then
		cp -R ${S} ${WORKDIR}/libv4l-x86
	fi
	tc-export CC
	emake PREFIX="/usr" LIBDIR="/usr/$(get_libdir)" CFLAGS="${CFLAGS}" \
		|| die "emake failed"
	if use multilib && use amd64; then
		multilib_env
		multilib_toolchain_setup "x86"
		cd ${WORKDIR}/libv4l-x86
		tc-export CC
		emake PREFIX="/usr" LIBDIR="/usr/$(get_libdir)" CFLAGS="${CFLAGS}" \
		 || die "emake failed"
	fi
}

src_install() {
	if use multilib && use amd64; then
		multilib_toolchain_setup "amd64"
	fi
	emake PREFIX="/usr" LIBDIR="/usr/$(get_libdir)" \
		DESTDIR="${D}" install || die "emake install failed"
	if use multilib && use amd64; then
		multilib_toolchain_setup "x86"
		cd ${WORKDIR}/libv4l-x86
		emake PREFIX="/usr" LIBDIR="/usr/$(get_libdir)" \
		    DESTDIR="${D}" install || die "emake install failed"
	fi
	dodoc ChangeLog README* TODO
}

pkg_postinst() {
	elog
	elog "libv4l includes wrapper libraries for compatibility and pixel format"
	elog "conversion, which are especially useful for users of the gspca usb"
	elog "webcam driver in kernel 2.6.27 and higher."
	elog
	elog "To add v4l2 compatibility to a v4l application 'myapp', launch it via"
	elog "LD_PRELOAD=/usr/$(get_libdir)/libv4l/v4l1compat.so myapp"
	elog "To add automatic pixel format conversion to a v4l2 application, use"
	elog "LD_PRELOAD=/usr/$(get_libdir)/libv4l/v4l2convert.so myapp"
	elog
}
