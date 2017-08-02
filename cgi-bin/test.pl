#!/usr/bin/perl -w 
use HTML::Template;
use CGI;
use strict;
use Encode;
use Encode::CN; #可写可不写
use utf8;

sub generate{
	my $s_file = shift();
	open FILE,"<:encoding(utf-8)" ,"u_file/$s_file.txt" or die "111no  such $!\n";
	#open FILE1,">" ,"summary.txt" or die "111no  such $!\n";
	if(!-d "message/$s_file") {
		system("mkdir  message/$s_file");    
	}
	## todo 删除unlink("$r_int/$filename");
	my $dat="消息对象";
	$dat=encode("gb2312",$dat);
	#print $dat;
	#exit;
	#my $ob=encode("gb2312","测");
	# 判断是否新联系人
	my $sw=0;
	# 判断时间是否正确
	my $sw1=0;
	my $mes;
	my $fn;
	my $i=0;
	my $filename;
	my $huizong;
	foreach(<FILE>){
		#print encode("gb2312",$_);
		my $str= encode("gb2312",$_);
		#next;
		if($sw1==1){
			$mes .=$str."\n";
			$sw1=0;
		}
		if($str =~ /$dat\:(.+)/g){
			if($sw==1){
				print FI $mes;
				close FI;
				if($mes eq ""){
					unlink("message/$s_file/$filename");
					#print $filename."\n";
				}
				$mes="";
				$sw=0;
			}
			chomp($str);
			$str =~ s/\://g;
			$str =~ s/\s\s+//g;
			$str =~ s/\?//g;
			$str =~ s/\/|\:\*|\?|\"|\<|\>|\|//g;
			
			$i++;
			$filename=$str.".txt";
			open FI,">", "message/$s_file/$filename" or die "no  such 1111111$!\n";

			$sw=1;
			next;
		}
		if($_ =~ /2017\-07/g){
			$mes .= $str."\n";
		
			$sw1=1;
		}
		
	}
	print FI $mes;
	sleep(1);
	close FI;
	if($mes eq ""){
		unlink("message/$s_file/$filename");
	}
	system("tar -czf message/$s_file".'.tar.gz'." message/$s_file");
	sleep(1);
	close FILE;
	
	return "message/".$s_file.".tar.gz";
	
}


1,
