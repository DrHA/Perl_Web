#!/usr/bin/perl -w 
use HTML::Template;
use CGI;
use strict;
use Encode;
use Encode::CN; #可写可不写
use utf8;
require "test.pl";

my $template = HTML::Template->new(filename => '../html/main.html');

my $req = new CGI;
#print $ENV{REQUEST_METHOD};
if($ENV{REQUEST_METHOD} eq "POST"){
	#print $ENV{REQUEST_METHOD};
	my $file = $req->param("FILE");
	if($file ne ""){
		my $r_int=int(rand(100000));
		open OUTFILE,">" ,"u_file/$r_int.txt";
		my $str;
		while(<$file>){
			print OUTFILE $_;
		}
		sleep(1);
		close (OUTFILE);
		generate($r_int);
		#generate($r_int);
		
		#my $re_file = $gfile; 
		my $re_file2 = "message/".$r_int.".tar.gz";
		#print $re_file2;
		$template->param(filename => $re_file2);
	}   
}else{
	$template->param(filename => "");
}
print "Content-Type: text/html\n\n", $template->output;


