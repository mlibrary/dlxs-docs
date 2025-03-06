
package TextClass;

# ----------------------------------------------------------------------
# NAME         : TextFilter
# CALLS        : SUPER 
# NOTES        : OVERRIDE the TextClass::TextFilter
# ----------------------------------------------------------------------
sub TextFilter
{
    my $self = shift;
    my ( $sRef ) = @_;

    # Make the author BIG, BIG, BIG
    $$sRef =~ s,(Author\:.*?),<font size=10>$1</font>,gs;

    return $results = $$sRef;
}

package SomeSubclass;

use TextClass ();

use vars qw( @ISA );
@ISA = qw( TextClass );

sub TextFilter
{
    my $self = shift;
    my ( $sRef ) = @_;

    # This is the note anchor of ptr-type notes
    $self->Filter_PTR_NotesForText( $sRef );

    my $results = $self->SUPER::TextFilter( $sRef );

    return $results;
}

1;

#!/l/local/bin/perl

use TextClass;
use SomeSubclass;  # if compile time binding


require "SomeSubclass.pm"; # if run time binding


my $subclassObject = SomeSubclass->new( $collid );

my $text = qq{Author: Phil Farber<NOTE1 N="1">DLPS staff</NOTE1>};


$subclassObject->TextFilter( \$text );

exit;

