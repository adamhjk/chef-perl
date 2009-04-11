package Chef::Recipe;

use warnings;
use strict;

use Moose;
use JSON;
use Data::Dumper;

has 'resource_collection' =>
  ( is => 'rw', isa => 'ArrayRef', default => sub { [] } );

sub add_resource {
  my $self = shift;

  foreach my $resource (@_) {
    push( @{ $self->{'resource_collection'} }, $resource );
  }

  1;
}

sub prepare_json {
  my $self = shift;
  my @resource_collection;
  foreach my $resource ( @{ $self->resource_collection } ) {
    push( @resource_collection, $resource->prepare_json );
  }
  return \@resource_collection;
}

1;
