TERMUX_PKG_HOMEPAGE=https://github.com/mvdan/sh
TERMUX_PKG_DESCRIPTION="A shell parser and formatter"
TERMUX_PKG_LICENSE="BSD 3-Clause"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="3.11.0"
TERMUX_PKG_SRCURL=https://github.com/mvdan/sh/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=69aebb0dd4bf5e62842c186ad38b76f6ec2e781188cd71cea33cb4e729086e94
TERMUX_PKG_AUTO_UPDATE=true

termux_step_make_install() {
	cd "$TERMUX_PKG_SRCDIR"

	termux_setup_golang

	export GOPATH="$TERMUX_PKG_BUILDDIR"
	mkdir -p "$GOPATH/src/github.com/mvdan"
	ln -sf "$TERMUX_PKG_SRCDIR" "$GOPATH/src/github.com/mvdan/sh"

	go build -modcacherw \
		-ldflags "-X main.version=$TERMUX_PKG_VERSION" \
		-o "$TERMUX_PREFIX/bin/shfmt" \
		./cmd/shfmt
}
