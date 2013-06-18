package CUDE::View::TELBOOK;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,
);

=head1 NAME

CUDE::View::TELBOOK - TT View for CUDE

=head1 DESCRIPTION

TT View for CUDE.

=head1 SEE ALSO

L<CUDE>

=head1 AUTHOR

BanaKing,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
