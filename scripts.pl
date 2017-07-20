#此文件是文件上传处理程序
#!/usr/bin/perl -w 
use HTML::Template;
use strict;
use CGI;
$onnum = 1;
while ($onnum != 11) {
	my $req = new CGI;
	my $file = $req->param("FILE$onnum");
	if ($file ne "") {
		my $fileName = $file;
		$fileName =~ s!^.*(\\|\/)!!;
		$newmain = $fileName;
		if ($allowall ne "yes") {
			if (lc(substr($newmain,length($newmain) - 4,4)) ne $theext){
				$filenotgood = "yes";
			}
		}
		if ($filenotgood ne "yes") {
			open (OUTFILE, ">$basedir/$fileName");
			print "$basedir/$fileName<br>";
			while (my $bytesread = read($file, my $buffer, 1024)) {
				print OUTFILE $buffer;
			}
			close (OUTFILE);
		}
	}
	$onnum++;
}
print "Content-type: text/html\n";
print "Location:$donepage\n\n"; 
