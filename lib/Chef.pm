package Chef;


use Chef::Recipe;
use Chef::Resource;
use Data::Dumper;
use JSON::Any qw(XS JSON DWIW);
use Chef::Syntax::resource;

require Exporter;
@ISA    = qw(Exporter);
@EXPORT = qw(resource2 node);

use warnings;
use strict;



=head1 NAME

Chef - The great new Chef!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';
our $recipe  = Chef::Recipe->new;
my $node_data;

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Chef;

    my $foo = Chef->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 function1

=cut

sub INIT {
 # load_node();
}

sub node {
  return $node_data;
}

sub load_node {
  my $data;
  while ( my $line = <STDIN> ) {
    $data = $data . $line;
  }
  $node_data = JSON::Any->jsonToObj($data);
  1;
}

sub resource {
  my $resource_type = shift;
  my $resource_name = shift;
  my $resource_sub  = shift;

  my $resource = Chef::Resource->new(
    {
      resource_type => $resource_type,
      name          => $resource_name,
      resource_sub  => $resource_sub
    }
  );
  $resource->evaluate();
  $recipe->add_resource($resource);
}

sub send_to_chef {
  print JSON::Any->objToJson(
    {
      node                => $node_data,
      resource_collection => $recipe->prepare_json
    }
  );
}

sub END {
  #send_to_chef;
}

=head1 AUTHOR

Adam Jacob, C<< <info at opscode.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-chef at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Chef>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Chef


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Chef>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Chef>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Chef>

=item * Search CPAN

L<http://search.cpan.org/dist/Chef/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Adam Jacob, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1;    # End of Chef
