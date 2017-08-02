#!/usr/bin/perl

# HTTP Header
print "Content-Type:application/octet-stream; name=\"1.txt\"\r\n";
print "Content-Disposition: attachment; filename=\"1.txt\"\r\n\n";

# Actual File Content will go hear.
open( FILE, "<FileName" );
while(read(FILE, $buffer, 100) )
{
   print("$buffer");
}