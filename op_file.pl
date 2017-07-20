#!/usr/bin/perl
#***************************************************
#Author       :  DR.HA
#Last modified:  9:02 2016/6/7
#Email        :  719520474@qq.com 
#Filename     :  op_file.pl
#Description  :  use this file‘s func to open a file
#***************************************************
use strict;
open (FILE,"<1.txt") or die "no  such $!\n";
#open (FI,">txt") or die "no  such $!\n";
$dat="消息对象";

$ob=decode("gb2312","测");
foreach(<FILE>){
	$str=decode("$_",$dat);
	if($str =~ /$dat\:*/g){
		print encode("gb2312",$_);
	}
	
}
#print FI $s;
#close FI;
close FILE;

