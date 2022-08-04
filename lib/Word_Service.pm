package Word_Service;

use Dancer2;
use Dancer2::Plugin::REST;

use Words;

our $VERSION = '0.1';

# Set up dictionary data structure
my $dictionary = Words->new();
$dictionary->read_word_list( config->{'dictionary'} );

# (very) simple test page on /
get '/' => sub {
    send_as html => config->{'readme'};
};

get '/ping' => sub {
    status_ok();
};

# JSON is default serializer
get '/wordfinder/:input' => sub {
    status_ok( $dictionary->check_string( params->{'input'} ) );
};

1;

__END__

=encoding utf-8

=head1 NAME

Word_Service - Dancer2 routes for simple word finder app

=head1 LICENSE

Copyright (C) Michael Brader.
This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 AUTHOR

Michael Brader E<lt>michael.brader@gmail.comE<gt>

=cut
