package CUDE::Model::MyCude;
use Moose;
use Cude::Interface; 
use DBI;
use namespace::autoclean;

extends 'Catalyst::Model';


sub connect_dbi{
  my $data =connect_db();
}

sub show_table {
	my ($self, $id) = @_;
	my $data =show($id);
	$data = @{$data};
	return "$data";
}

=head1 NAME

CUDE::Model::MyCude - Catalyst Model

=head1 DESCRIPTION

Catalyst Model.


=encoding utf8

=head1 AUTHOR

BanaKing,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
