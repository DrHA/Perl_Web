#此文件用来存放常用方法，以后可拆分为多个
#!/usr/bin/perl -w 
use HTML::Template;

my $template = HTML::Template->new(filename => '../html/main.html');

# fill in some parameters
# $template->param(HOME => $ENV{HOME});
# $template->param(PATH => $ENV{PATH});

# send the obligatory Content-Type and print the template output
print "Content-Type: text/html\n\n", $template->output;