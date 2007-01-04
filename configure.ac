
AC_INIT([abiword-docs],[0.0.1],[http://www.abisource.com/])
AM_INIT_AUTOMAKE

PKG_PROG_PKG_CONFIG

abi_pkg='abiword-2.5'
PKG_CHECK_MODULES([ABIWORD_EXTRAS_DEPS], [ "$abi_pkg" ], [
	ABIWORD_EXTRAS_PKGDATADIR=`$PKG_CONFIG --variable=pkgdatadir $abi_pkg`
])
AC_SUBST(ABIWORD_EXTRAS_PKGDATADIR)

AC_CONFIG_FILES([
  Makefile
  ABW/Makefile
])
AC_OUTPUT

echo "
    Configuration:
        installing to:        ${ABIWORD_EXTRAS_PKGDATADIR}
"
