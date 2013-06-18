package CUDE::Controller::Telephone;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

CUDE::Controller::Telephone - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched CUDE::Controller::Telephone in Telephone.');
}



sub table :Local {
	my ($self, $c) = @_;
	my $id = $c->req->body_params->{id};
	$c -> model ('MyCude') -> connect_dbi;

	$c -> stash (
		result => $c->model('MyCude')->show_table($id),
		connect_1 => $c->model ('MyCude') -> connect_dbi,
  	template => 'telephone/list.tt2',

		);
}

=encoding utf8

=head1 AUTHOR

BanaKing,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
