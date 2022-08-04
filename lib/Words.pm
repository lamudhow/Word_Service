package Words;

use 5.018;
use Moo;
use Function::Parameters qw/ :strict /;
use Readonly;

our $VERSION = "0.1";
# persistent word list
has '_dictionary' => (
    is => 'rw',
    init_arg => undef,
);

method read_word_list($word_list_file) {
    die "Word list file $word_list_file does not exist or is not readable"
        unless -r $word_list_file;

    open my $fh, '<', $word_list_file
        or die "Failed to open $word_list_file for reading: $!";

    my $words = [];
  WORD:
    while (my $word = <$fh>) {
        chomp $word;
        # Most word lists have all the single letters but we'll only
        # add 'a' and 'I'
        if ( length($word) == 1 && $word !~ /[aI]/ ) {
            next WORD;
        }
        push @{ $words }, $word;
    }

    close $fh or die "Failed to close $word_list_file after reading: $!";

    die "No words found in word list file $word_list_file"
        unless @{ $words };

    $self->_dictionary($words);

    return 1;
}

# the heart of the word finder. Creates a letter frequency hash of the
# candidate then cycles through the dictionary building a similar
# hash, excluding the word if:
#
# * it is longer than the candidate
# * it contains letters not in the candidate
# * it contains more instances of a particular letter than the candidate
#
# If any words are not excluded they are returned in a list reference,
# otherwise the empty list is returned
method check_string($candidate) {
    my $dictionary = $self->_dictionary();

    die 'Dictionary not initialised with read_word_list'
        unless defined $dictionary;

    # Assumption: answer for empty string is empty list
    return [] unless $candidate;

    my $strlen = length $candidate;

    # Build a hash with letter counts from str
    my $letter_counts;
    foreach my $letter (split //, $candidate) {
        $letter_counts->{$letter}++;
    }

    my $answers = [];
  WORD:
    foreach my $word ( @{ $dictionary } ) {
        if (length $word > $strlen) {
            next WORD;
        }
        my $letters_found;
        foreach my $letter (split //, $word) {
            next WORD unless exists $letter_counts->{$letter};
            next WORD
                unless ++$letters_found->{$letter} <= $letter_counts->{$letter};
        }
        push @{ $answers }, $word;
    }

    return $answers;
}

1;

__END__

=encoding utf-8

=head1 NAME

Words - Simple dictionary store with method to find words that contain
certain letters

=head1 BUGS AND LIMITATIONS

We just keep the dictionary in a list. If we had a larger word list or
performance was tight we'd probably want to create an index of some
sort and/or cache the split words.

There's no consideration of Unicode and letters that are semantically
identical but have different codepoints.

We make the following assumptions that weren't specified:

 * Single letter words except 'a' & 'I' are to be ignored

 * candidate strings and dictionary words are case
   sensitive. ie. 'dog' does not match 'Dog'

=head1 LICENSE

Copyright (C) Michael Brader.
This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 AUTHOR

Michael Brader E<lt>michael.brader@gmail.comE<gt>

=cut
