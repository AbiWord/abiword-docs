
AC_INIT([abiword-docs],[2.6.0],[http://www.abisource.com/])
AM_INIT_AUTOMAKE

PKG_PROG_PKG_CONFIG

abi_pkg='abiword-2.6'
PKG_CHECK_MODULES([ABIWORD_EXTRAS_DEPS], [ "$abi_pkg" ], [
	ABIWORD_EXTRAS_PKGDATADIR=`$PKG_CONFIG --variable=pkgdatadir $abi_pkg`
])
AC_SUBST(ABIWORD_EXTRAS_PKGDATADIR)

AC_CHECK_PROG(ABIWORD, abiword, abiword)
AC_SUBST(ABIWORD)
AC_ARG_VAR(ABIWORD, AbiWord program, used for converting help files)
if test "x$ABIWORD" == "x"; then
	AC_MSG_ERROR([abiword not found in PATH], 1)
fi

AC_CONFIG_FILES([
  Makefile
  ABW/Makefile
  ABW/en-US/Makefile
  ABW/en-US/howto/Makefile
  ABW/en-US/info/Makefile
  ABW/en-US/interface/Makefile
  ABW/en-US/plugins/Makefile
  ABW/en-US/problems/Makefile
  ABW/en-US/tutorial/Makefile
  ABW/fr-FR/Makefile
  ABW/fr-FR/howto/Makefile
  ABW/fr-FR/info/Makefile
  ABW/fr-FR/interface/Makefile
  ABW/fr-FR/plugins/Makefile
  ABW/fr-FR/problems/Makefile
  ABW/fr-FR/tutorial/Makefile
  ABW/pl-PL/Makefile
  ABW/pl-PL/howto/Makefile
  ABW/pl-PL/info/Makefile
  ABW/pl-PL/interface/Makefile
  ABW/pl-PL/plugins/Makefile
  ABW/pl-PL/problems/Makefile
  ABW/pl-PL/tutorial/Makefile
])
AC_OUTPUT

echo "
    Configuration:
        installing to:        ${ABIWORD_EXTRAS_PKGDATADIR}
"
