#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and only have a single target Dancer app to run here
use Word_Service;

Word_Service->to_app;

=begin comment
# use this block if you want to include middleware such as Plack::Middleware::Deflater

use Word_Service;
use Plack::Builder;

builder {
    enable 'Deflater';
    Word_Service->to_app;
}

=end comment

=cut

=begin comment
# use this block if you want to mount several applications on different path

use Word_Service;
use Word_Service_admin;

use Plack::Builder;

builder {
    mount '/'      => Word_Service->to_app;
    mount '/admin'      => Word_Service_admin->to_app;
}

=end comment

=cut

