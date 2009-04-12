#!/usr/bin/perl

use FindBin;
use lib ("$FindBin::Bin/../lib");
use Chef;
use Chef::Syntax::resource;
use Data::Dumper;

foo bar ('/tmp/filename') {
  print "Why go home..\n";
  print Data::Dumper->Dump([ $r ]);
}

bar();

# resource file => '/tmp/', sub {
#   my $r = shift;
#   $r->mode('0644');
#   $r->owner('adam');
#   $r->group('root');
# };
# 
# resource template => 'foo', sub {
#   my $r = shift;
#   $r->mode('0644');
#   $r->variables({
#     one => 'two',
#     three => 'four'
#   })
# };
# 
# resource service => "apache2", sub {
#   my $r = shift;
#   $r->action("restart");
# };
# 
# 1;
