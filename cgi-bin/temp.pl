#!/usr/bin/perl -w 
use HTML::Template;
use CGI;
use strict;
use Encode;
use Encode::CN; #可写可不写
use utf8;

sub upload_file{
	my $req = shift();
	#my $basedir = "/var/www/cgi-bin/"; #上传的文件存放地址

	#my $theext = ".txt"; #要限制的文件后缀名
	my $message= "";
	my $file1 = $req->param("FILE");
	if ($file1 ne "") {
		my $fileName = $file1;
		#$fileName =~ s/^.*(\\|\/)//; #用正则表达式去除无用的路径名，得到文件名
		#my $newmain = $fileName;
		#my $filenotgood;

		#my $extname = lc(substr($newmain,length($newmain) - 4,4)); #取后缀名
		#if ($extname eq $theext){
		#	$filenotgood = "yes";
		#}


		#if ($filenotgood ne "yes") { #这段开始上传
		open (OUTFILE, ">$fileName");
		#print "$fileName\n";
		binmode(OUTFILE);
		#务必全用二进制方式，这样就可以放心上传二进制文件了。而且文本文件也不会受干扰
		while (read($file1,  my $buffer, 1024)) {
			print OUTFILE $buffer;
		}
		close (OUTFILE);
		print "$fileName";
		#system("bl2seq -i $fileName -j $fileName -p blastn -o junk");
		#system("rm $fileName");
		$message.=$file1 . " succ\n";
		#}
		#else{
		#	$message.=$file1 . " errot houzhui budui upload!<br>\n";
		#}
	}
	my $re_f = (
		"message" => $message,
		"file" =>$file1,
	);
	print $message; #最后输出上传信息
	return $re_f;
}

sub generate{
	my $s_file = shift();
	open FILE,"<:encoding(utf-8)" ,"u_file/$s_file" or die "111no  such $!\n";
	#open FILE1,">" ,"summary.txt" or die "111no  such $!\n";
	my $r_int=int(rand(100000));
	if(!-d "$r_int") {
		system("mkdir  $r_int");    
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
					#print $filename."rm";
					unlink("message/$r_int/$filename");
					print $filename."\n";
				}
				$mes="";
				$sw=0;
			}
			chomp($str);
			$str =~ s/\://g;
			$str =~ s/\s\s+//g;
			$str =~ s/\?//g;
			$str =~ s/\/|\:\*|\?|\"|\<|\>|\|//g;
			print $str.$i;
			$i++;

			$filename=$str.".txt";
			open FI,">", "message/$r_int/$filename" or die "no  such 1111111$!\n";

			$sw=1;
			next;
		}
		if($_ =~ /2017\-07/g){
			$mes .= $str."\n";
		
			$sw1=1;
		}
		
	}
	print FI $mes;

	close FI;
	if($mes eq ""){
		unlink("message/$r_int/$filename");
	}
	system("tar -czf $r_int".'.tar.gz'." message/$r_int");
	
	close FILE;
	
	return  "cgi-bin/".$r_int.'.tar.gz';
	
}