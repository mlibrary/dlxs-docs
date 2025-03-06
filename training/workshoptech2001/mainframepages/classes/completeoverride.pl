package TextClass;


sub TextFilter
{
    my $self = shift;
    my ( $sRef ) = @_;

    # Make the author BIG, BIG, BIG
    $$sRef =~ s,(Author\:.*?),<font size=10>$1</font>,gs;

    return $results;
}

package SomeSubclass;

use TextClass ();

use vars qw( @ISA );
@ISA = qw( TextClass );

sub TextFilter
{
    my $self = shift;
    my ( $sRef ) = @_;

    # NO CALL TO SUPER !!

    # Make the author SMALL SMALL SMALL
    $$sRef =~ s,(Author\:.*?),<font size=2>$1</font>,gs;

    return $results;
}

1;



# **************************************************
# **************************************************
# **************************************************
#
# In the file text-idx (main program
#
# **************************************************

#!/l/local/bin/perl

use TextClass;
use SomeSubclass;  # if compile time binding


require "SomeSubclass.pm"; # if run time binding


my $subclassObject = SomeSubclass->new( $collid );

my $text = 'Author: Phil Farber';


$subclassObject->TextFilter( \$text );

exit;

