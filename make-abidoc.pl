#! /usr/bin/env perl

#  The AbiWord Document Merger
#
#  Copyright (C) 2002 Free Software Foundation.
#
#  make-abidoc is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as
#  published by the Free Software Foundation; either version 2 of the
#  License, or (at your option) any later version.
#
#  make-abidoc is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#  Author(s): Kenneth Christiansen
#  Cleanup, other alterations: Dom Lachowicz

## Release information
my $PROGRAM  = "make-abidoc";
my $VERSION  = "0.1";
my $PACKAGE = "AbiWord";

## Loaded modules
use strict;
use Getopt::Long;

## Scalars used by the option stuff
my $HELP_ARG 	   = "0";
my $VERSION_ARG    = "0";
my $HEADER_ARG     = "0";
my $FOOTER_ARG     = "0";
my $BODY_ARG       = "0";
my $TITLE_ARG      = "0";
my $OUT_ARG        = "0";

## Always print as the first thing
$| = 1;

## Handle options
GetOptions (
	    "help|h"	  	  => \$HELP_ARG,
	    "version|v" 	  => \$VERSION_ARG,
	    "header|s=s"	  => \$HEADER_ARG,
	    "footer|f=s"   	  => \$FOOTER_ARG,
	    "title|t=s"           => \$TITLE_ARG,
            "output|o=s"          => \$OUT_ARG, 
	    ) or &invalid_option;

my $OPTION = $ARGV[0];
my $OUTNAME = "0";

## Use the supplied arguments
## This section will check for the different options.

sub handle_options () {

    if ($VERSION_ARG) {
	&version;
	exit;
    } 

    if ($HELP_ARG) {
	&help;
	exit;
    }

    if ($OUT_ARG) {
        $OUTNAME = $OUT_ARG;
    }

    if (!$OPTION || !$HEADER_ARG || !$FOOTER_ARG) {
	&help;
    }

    $BODY_ARG = $OPTION;
}

&main;

sub string_from_file ($filename)
{
    my ($filename) = @_;    

    my $string; {
	local (*IN);
	local $/; # slurp mode
	open (IN, "<$filename") || die "can't open $filename: $!";
	$string = <IN>;
    }

    return $string;
}

sub main
{
    &handle_options;

    my $body = &string_from_file ($BODY_ARG);

    if ($HEADER_ARG) {
	my $header = &string_from_file ($HEADER_ARG);
	$body = &replace_header ($body, $header);
    }

    if ($FOOTER_ARG) {
     	my $footer = &string_from_file ($FOOTER_ARG);
	$body = &replace_footer ($body, $footer);
    }

    if ($TITLE_ARG) {
	$body = &replace_title ($body, $TITLE_ARG);
    }

    if ($OUTNAME) {
	open OUT, ">$OUTNAME";
	print OUT $body;
	close OUT
    }
    else {
	print $body;
    }
}

sub replace_title ($body, $title)
{
    my ($body, $title) = @_;
    $body =~ s/{TITLE}/$1$title$2/gs;
    
    return $body;
}

sub replace_header ($body, $header)
{
    my ($body, $header) = @_;
    $body =~ s/.*<div>(.*)/$header$1/ms;
    
    return $body;
}

sub replace_footer ($body, $footer)
{
    my ($body, $footer) = @_;
    $body =~ s/(.*)<\/div>.*/$1$footer/ms;
    
    return $body;
}

sub version
{
    ## Print version information
    print "${PROGRAM} (${PACKAGE}) $VERSION\n";
    print "Written by Kenneth Christiansen <kenneth\@gnu.org>, 2002.\n\n";
    print "Copyright (C) 2002 Free Software Foundation, Inc.\n";
    print "This is free software; see the source for copying conditions.  There is NO\n";
    print "warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n";
    exit;
}

sub help
{
    ## Print usage information
    print "Usage: ./${PROGRAM} [OPTIONS] --header=HEADER --footer=FOOTER XHTML-FILE\n";
    print "Replaces header and/or footer of XHTML file\n\n";
    print "  -H, --help                   shows this help page\n";
    print "  -S, --header=HEADER          the header to use\n";
    print "  -F, --footer=FOOTER          the footer to use\n";
    print "  -O, --output=NEWFILE         saves output in NEWFILE\n";
    print "  -T, --title                  the title to use\n";
    print "  -V, --version                shows the version\n";
    print "Report bugs to bugzilla.abiword.com.\n";
    exit;
}

sub invalid_option
{
    ## Handle invalid arguments
    print "${PROGRAM}: invalid option -- $OPTION\n";
    print "Try `${PROGRAM} --help' for more information.\n";
    exit 1;
}