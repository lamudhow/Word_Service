#!/usr/bin/env perl

use strict;
use warnings;
use 5.018;

use Test2::V0;
use Readonly;
use File::Temp;

Readonly my $DICT_FILE => "/usr/share/dict/words";

use Words;

my $words = Words->new();

is( ref $words, 'Words', 'Constructor');

like( dies { $words->read_word_list() },
    qr/\A\QToo few arguments for method read_word_list (expected 2, got 1)\E/,
    'No Arg'
);

# Doesn't exist
{
    my $de_dir = File::Temp->newdir();
    my $de_file = "${de_dir}/foo";
    like( dies { $words->read_word_list($de_file) },
        qr/\A\QWord list file $de_file does not exist or is not readable/,
        "Doesn't exist"
    );
}

# Not readable.
{
    my $nr_file = File::Temp->new();
    chmod 0000, $nr_file;
    like( dies { $words->read_word_list($nr_file) },
          qr/\A\QWord list file $nr_file does not exist or is not readable/,
          'Not readable (may fail on NTFS or other non UNIX filesystems)'
      );
}

# Empty file
{
    my $empty_file = File::Temp->new();
    like( dies { $words->read_word_list($empty_file) },
          qr/\A\QNo words found in word list file $empty_file/,
          'Empty file'
      );
}

# Not read in yet
like( dies { $words->check_string('dgo') },
      qr/\ADictionary not initialised with read_word_list/,
      'Not read in yet'
);

# Create word list
{
    my $fh = File::Temp->new();
    my $fname = $fh->filename;
    print {$fh} $_ for <DATA>;
    close $fh;
    ok( lives { $words->read_word_list($fname) }, 'Read Word List' );

    # Args
    like( dies { $words->check_string() },
          qr/\A\QToo few arguments for method check_string (expected 2, got 1)\E/,
          'No Arg'
      );

    # Specified test
    is( $words->check_string('dgo'), [ qw/ do dog go god / ], 'Specified test' );

    is( $words->check_string('Dgo'), [ qw/ Dog go / ], 'Capitals' );

    is( $words->check_string('a'), [ qw/ a / ], 'Single letter a' );
    is( $words->check_string('I'), [ qw/ I / ], 'Single letter I' );
    is( $words->check_string('A'), [], 'Single letter A' );
    is( $words->check_string('i'), [], 'Single letter i' );
    is( $words->check_string('b'), [], 'Single letter b' );

    is( $words->check_string('tttooa'), [ qw/ a at tattoo to too / ], 'Duplicate Letters' );

    is( $words->check_string('caf??'), [ qw/ a caf?? / ], 'Latin Extended' );
}

# That's all she wrote
done_testing();

todo "Advanced tests" => sub {
    # UTF-8
    # is( $words->check_string('???OH'), [ qw/ H???O O??? / ], 'Basic UTF-8' );
    # H???O
    # H???S
    # O???

    # standard dictionary tests: /usr/share/dict/words
};

__DATA__
A
Dog
I
a
at
b
c
caf??
do
dog
foe
fog
go
god
goo
good
i
tattoo
tattoos
to
too
tooo
voodoo
