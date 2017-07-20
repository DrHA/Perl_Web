#!/usr/bin/perl
use strict;
use CGI;
print "Content-type: text/html ";

open FILE ,("<","../html/main.html") or die "  kkkk $!";
foreach(<FILE>){
	print $_;

}
close FILE;

