use strict;
use warnings;

use Word_Service;
use Test::More tests => 6;
use Plack::Test;
use Test::JSON;
use HTTP::Request::Common;
use Ref::Util qw<is_coderef>;

my $app = Word_Service->to_app;
ok( is_coderef($app), 'Got app' );

my $test = Plack::Test->create($app);
my $res  = $test->request( GET '/' );

ok( $res->is_success, '[GET /] successful' );

$res = $test->request( GET '/ping' );

ok( $res->is_success, '[GET /ping] successful' );

$res = $test->request( GET '/wordfinder/dgo' );

ok( $res->is_success, '[GET /wordfinder/dgo] successful' );

my $content = $res->content();

is_valid_json( $content, 'Valid JSON' );

is_json( $content, '[ "do", "dog", "go", "god" ]', 'Correct words' );
