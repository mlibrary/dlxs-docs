
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

# Make this code available in ONE PLACE to subclasses that need Greek
# character entities filtered
sub GreekEntityFilter
{
    my $self = shift;
    my $sRef = shift;

    &DlpsUtils::FilterGreekEntities( $sRef );
}


package SomeSubclass;

use TextClass ();

use vars qw( @ISA );
# Subclass of TextClass.pm module
@ISA = qw( TextClass );


sub TextFilter
{
    my $self = shift;
    my ( $sRef ) = @_;

    $self->GreekEntityFilter( $sRef );

    my $results = $self->SUPER::TextFilter( $sRef );

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

