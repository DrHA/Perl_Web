#!/usr/bin/perl -w 
use HTML::Template;
use CGI;
use strict;
use Encode;
use Encode::CN; #可写可不写
use utf8;

sub generate{
	my $s_file = shift();
	my $year = shift();
	my $mon = shift();
	my $key_word = shift();
	my %result_hash;
	open FILE,"<:encoding(utf-8)" ,"u_file/$s_file.txt" or die "111no  such $!\n";

	if(!-d "message/$s_file") {
		system("mkdir  message/$s_file");    
	}
	open FILE1,">" ,"message/$s_file/summary.txt" or die "111no  such $!\n";
	my $s_str;
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
	my $mes="";
	my $fn;
	my $i=0;
	my $filename;
	my $huizong;
	my $datestring = localtime();
	foreach(<FILE>){
		#print encode("gb2312",$_);
		my $str= encode("gb2312",$_);
		#next;
		if($sw1==1){
			$mes .=$str."\n";
			$s_str .= $str."\n";
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
		
		if($_ =~ /$year\-$mon/g){
			$mes .= $str."\n";
			$s_str .= $str."\n";
			$sw1=1;
		}
		
	}
	print FI $mes;
	#sleep(1);
	close FI;
	#summary
	print FILE1 $s_str;
	#sleep(1);
	close FILE1;
	
	# 频率
	#if($key_word){
	#	my $result = get_rate($s_str,$key_word);
	#	$result_hash{rate} = $result;
	#}

	
	if($mes eq ""){
		unlink("message/$s_file/$filename");
	}
	system("tar -czf message/$s_file".'.tar.gz'." message/$s_file");
	system("rm -rf message/$s_file");
	#sleep(1);
	close FILE;
	
	$result_hash{file_name} = "message/".$s_file.".tar.gz";
	
	return $s_str;
	
}
# 验证文件格式是否正确 
# 例子 get_formate("aaa.txt","txt");格式正确返回1 错误返回0
sub get_formate{
	# 获取文件名
	my $filename = shift();
	# 获取要验证的文件格式
	my $formate = shift();
	my $allow = 0;
	if($filename =~ /\.$formate$/g){
		$allow = 1;
	}	
	return $allow;
}

#  查找关键字的频率
sub get_rate{
	# 获取文本
	my $r_string = shift();
	my $r_string=decode("gb2312",$r_string);
	$r_string=encode("utf8",$r_string);
	# 获取关键字
	my $tmp_key_word = shift();
	my @key_word = split(/,/,$tmp_key_word);
	#my @result;
	my @rates;
	#my $tmp;
	foreach(@key_word){
		#my $dat=encode("gb2312",$_);
		#print $dat."    ".$_;
		my $count=($r_string =~ s/$_/$_/g);
		if(!$count){
			$count=0;
		}
		my  %row_data;
		$row_data{key_word} = $_;
		$row_data{rate} = $count;		
		push(@rates,\%row_data);
	}
	#my %row_data; # 使用新的散列
	# fill in this row
	#$row_data{key_word} = shift @key_word;
	#$row_data{rate} = shift @rates;
	# 先将数据保存在散列中，然后在压入数组
	#push(@result, \%row_data);
	#return \@result;
	return \@rates;
}

1,
