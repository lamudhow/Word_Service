package Words;

use 5.018;
use Moo;
use Function::Parameters qw/ :strict /;
use Readonly;

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
        # add 'a' and 'i'
        if ( length($word) == 1 && $word !~ /[ai]/ ) {
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
    my $word_count = 0;
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
    
    unless () {
    }
    my @answers;
  WORD:
    foreach my $word (  ) {
    }
    while (my $line = <$fh>) {
    chomp $line;
    my $len = length $line;
    next LINE if $len < $min;
    next LINE if $len > $max;
    # Evaluate candidate
    my $cfound;
  LETTER:
    foreach my $letter (split //, $line) {
        next LINE unless exists $count->{$letter};
        next LINE unless ++$cfound->{$letter} <= $count->{$letter};
    }
    push @answers, $line;
}

if (@answers) {
    say for sort { length $a <=> length $b } @answers;
}
