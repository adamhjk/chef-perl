package Chef::Syntax::resource;

use warnings;
use strict;

use Data::Dumper;
use base qw(Devel::Declare::MethodInstaller::Simple);

sub import {
  my $class = shift;
  my $caller = caller;

  my $arg = shift;

  $class->install_methodhandler(
      into            => $caller,
      name            => 'foo',
  );
}

sub parser {
  my $self = shift;
  $self->init(@_);

  $self->skip_declarator;
  my $name   = $self->strip_name;
  my $proto  = $self->strip_proto;
  my $attrs  = $self->strip_attrs;
  my @decl   = $self->parse_proto($proto);
  my $inject = $self->inject_parsed_proto(@decl);
  if (defined $name) {
    $inject = $self->scope_injector_call() . $inject;
  }
  $self->inject_if_block($inject, $attrs ? "sub ${attrs} " : '');

  print Data::Dumper->Dump([$attrs]);

  $self->install( $name );

  return;
}

sub parse_proto {
  my $ctx = shift;
  my ($proto) = @_;
    
  print Data::Dumper->Dump([ $ctx ]);
  my $inject = 'my $resource_type = "' . $ctx->{name} . '";';
  if (defined $proto) {
    $inject .= 'my $resource_name = ' . $proto . ';';
  } else {
    die "You must supply a resource name!";
  }
  $inject .= 'my $r = Chef::Resource->new({ resource_type => $resource_type, name => $resource_name });';
  return $inject;
}

1;