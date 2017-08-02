#!/usr/bin/perl
use CGI;
# HTTP Header
my $req = new CGI;
my $file = $req->param("name");
print "Content-Type:application/octet-stream; name=\"$file\"\r\n";
print "Content-Disposition: attachment; filename=\"$file\"\r\n\n";

# Actual File Content will go hear.
open( FILE, "<$file" );
while(read(FILE, $buffer, 100) ){
   print("$buffer");
}