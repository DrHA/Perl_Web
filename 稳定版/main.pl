#!/usr/bin/perl -w 
use HTML::Template;
use CGI;
use strict;
use Encode;
use Encode::CN; #可写可不写
use utf8;
require "test.pl";
## 2017/11/8 update 自动日期,判断文件格式,筛选后自动删除
## todo判断繁体
## #1代表变更，#2代表之前的
my $template = HTML::Template->new(filename => '../html/main.html');
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(); #1
$year += 1900;
if($mon <= 9){
	if($mon < 1){
		$mon = 12;
	}else{
		$mon = "0".$mon;
	}
}
$template->param(year => $year); #1
$template->param(mon => $mon); #1
my $req = new CGI;
#print $ENV{REQUEST_METHOD};
if($ENV{REQUEST_METHOD} eq "POST"){
	#print $ENV{REQUEST_METHOD};
	my $file = $req->param("FILE");
	my $allow = get_formate($file,"txt");
	$template->param(allow => $allow); #1
	$template->param(filename => $file);
	## 判断格式是否正确
	if($file ne "" && $allow){
		my $r_int=int(rand(100000));
		open OUTFILE,">" ,"u_file/$r_int.txt";
		my $str;
		while(<$file>){
			print OUTFILE $_;
		}
		sleep(1);
		close (OUTFILE);
		#generate($r_int);
		generate($r_int,$year,$mon);
		unlink("u_file/$r_int.txt");
		#my $re_file = $gfile; 
		my $re_file2 = "message/".$r_int.".tar.gz";
		#print $re_file2;
		$template->param(filename => $re_file2);
	}   
}
print "Content-Type: text/html\n\n", $template->output;

