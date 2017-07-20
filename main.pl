#此文件控制main.html
#!/usr/bin/perl -w 
use HTML::Template;
use strict;
use CGI;


if ($ENV{'REQUEST_METHOD'} eq "POST"){
    
}else {
	$buffer = $ENV{'QUERY_STRING'};
}

my $template = HTML::Template->new(filename => '../html/main.html');

# fill in some parameters
# $template->param(HOME => $ENV{HOME});
# $template->param(PATH => $ENV{PATH});

# send the obligatory Content-Type and print the template output
print "Content-Type: text/html\n\n", $template->output;