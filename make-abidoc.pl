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
my $INFO_ARG       = "0";
my $OUT_ARG        = "0";

## Scalars used by the substitution code
my $TITLE_ARG     = "";
my $AUTHOR_ARG    = "";
my $HIERARCHY_ARG = "";

## Always print as the first thing
$| = 1;

## Handle options

GetOptions (
	    "help|h"	  	  => \$HELP_ARG,
	    "version|v" 	  => \$VERSION_ARG,
	    "header|s=s"	  => \$HEADER_ARG,
	    "footer|f=s"   	  => \$FOOTER_ARG,
	    "info|i=s"            => \$INFO_ARG,
            "output|o=s"          => \$OUT_ARG, 
	    ) or &invalid_option;

my $OPTION = @ARGV;
my $OUTNAME = "0";

#exit;

&main;

## Use the supplied arguments
## This section will check for the different options.
## edited by cal

sub handle_options () {

    if ($VERSION_ARG) {
	&version;
	exit;
    } 

    if ($HELP_ARG) {
	&version;
	&help;
	&exit;
    }

    if (!$HEADER_ARG || !$FOOTER_ARG || !$INFO_ARG) {
	&help;
	&exit;
    }

    if ($OUT_ARG) {
        $OUTNAME = $OUT_ARG;
    }

    $BODY_ARG = $INFO_ARG;
    $BODY_ARG =~ s/.info/.xhtml/;
}

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

sub read_info_file($filename)
{
    my ($filename) = @_;

    open( INFO, $filename ) or die "Can't open input $filename file: $!" ;

    ## read in these variables, remove trailing newline
    $TITLE_ARG = <INFO>; chomp $TITLE_ARG;
    $AUTHOR_ARG = <INFO>; chomp $AUTHOR_ARG;
    $HIERARCHY_ARG = <INFO>; chomp $HIERARCHY_ARG;

    close ( INFO );
}

sub main
{
    &handle_options;

    &read_info_file ($INFO_ARG);

    my $body = &string_from_file ($BODY_ARG);

    my $header = &string_from_file ($HEADER_ARG);
    $body = &replace_header ($body, $header);

    my $footer = &string_from_file ($FOOTER_ARG);
    $body = &replace_footer ($body, $footer);

    ## replace these variables
    $body = &replace_title ($body, $TITLE_ARG);
    $body = &replace_author ($body, $AUTHOR_ARG);
    $body = &replace_hierarchy ($body, $HIERARCHY_ARG);

    if ($OUTNAME) {
	open OUT, ">$OUTNAME";
	print OUT $body;
	close OUT
    }
    else {
	print "${body}\n";
    }
}

sub replace_author($body, $author)
{
    my ($body, $author) = @_;
    $body =~ s/{AUTHOR}/$1$author$2/gs;
    
    return $body;
}

sub replace_hierarchy($body, $hierarchy)
{
    my ($body, $hierarchy) = @_;
    $body =~ s/{HIERARCHY}/$1$hierarchy$2/gs;
    
    return $body;
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
    print "  -I, --info                   the info file to use\n";
    print "  -V, --version                shows the version\n";
    print "Report bugs to bugzilla.abiword.com.\n";
}

sub invalid_option
{
    ## Handle invalid arguments
    print "${PROGRAM}: invalid option -- $OPTION\n";
    print "Try `${PROGRAM} --help' for more information.\n";
    exit 1;
}
