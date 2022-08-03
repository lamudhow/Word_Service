requires 'perl', '5.018000';

requires $_ for
    qw/
          Dancer2
          Dancer2::Plugin::REST
          Plack
          Moo
          Readonly
          Function::Parameters
      /;

# We're sending the test harnesses to the container so no 'on "test"'

requires $_ for
    qw/
          Test::More
          Plack::Test
          Test::JSON
          HTTP::Request::Common
          Ref::Util
          Test2::Suite
          File::Temp
      /;
