use strict;
my $r_string="安文杰安文杰是实时";
my $keys="安";
my $count = ($r_string =~ s/$keys//g);
print $count;