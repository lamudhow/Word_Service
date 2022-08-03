package Word_Service;

use Dancer2;
use Dancer2::Plugin::REST;

use Words;

our $VERSION = '0.1';

# Set up dictionary data structure
my $dictionary = Words->new();
$dictionary->read_word_list( config->{'dictionary'} );

get '/' => sub {
    send_as html => config->{'readme'};
};

get '/ping' => sub {
    return status_ok();
};

get '/wordfinder/:input' => sub {
    status_ok( $dictionary->check_string( params->{'input'} ) );
};

true;
