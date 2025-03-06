# **************************************************
# **************************************************
# **************************************************
# **************************************************
#
# In the file TextClass.pm
#
# **************************************************

package TextClass;

# ----------------------------------------------------------------------
# NAME      : new
# PURPOSE   : create new TextClass object
#
# CALLED BY : main
# CALLS     : TextClass->_initialize
# NOTES     :
# ----------------------------------------------------------------------
sub new
{
    my $class = shift;
    my $self = {};
    
    # Note 2 parameter form of 'bless' allows inheritance

    bless $self, $class;
    $self->_initialize( @_ );
    return $self;
}

# ----------------------------------------------------------------------
# NAME      : _initialize
# CALLED BY : new
# INPUT     : see new
# ----------------------------------------------------------------------
sub _initialize
{
    my $self = shift;

    my ( $collid ) = @_;

    $self->{'baseclass data key'} = 'base class value';
}

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

# **************************************************
# **************************************************
# **************************************************
#
# In the file SomeSubclass.pm 
#
# **************************************************

package SomeSubclass;

use TextClass ();

use vars qw( @ISA );
# Subclass of TextClass.pm module
@ISA = qw( TextClass );

# ----------------------------------------------------------------------
# NAME      : _initialize
# PURPOSE   : create structure for TextClass object
# CALLED BY : new
# INPUT     : see new
# NOTES     : overrides Base Class _initialize
# ----------------------------------------------------------------------

sub _initialize
{
    my $self = shift;
    $self->SUPER::_initialize( @_ );


    $self->{'baseclass data key'} = 'some other value';
}

# ----------------------------------------------------------------------
# NAME         : TextFilter
# PURPOSE      :
#              :
# CALLS        : SUPER 
# INPUT        : $sRef (reference to search result string
# NOTES        : OVERRIDE the TextClass::TextFilter method to handle
#              : Notes filtering
# ----------------------------------------------------------------------

sub TextFilter
{
    my $self = shift;
    my ( $sRef ) = @_;

    # This is the note anchor of ptr-type notes
    $self->Filter_PTR_NotesForText( $cgi, $collid, $sRef );

    my $results = $self->SUPER::TextFilter( $sRef );

    # excise the 'Availability' table row.
    $results =~ s,(Author\:.*?)<tr.*?<strong>Availability\:.*?</tr>,$1,;

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

# Create an instance (object) of Class SomeSubclass
my $subclassObject = SomeSubclass->new( $collid );

my $text = 'Author: Phil Farber';

# Pass text data to object to filter it
$subclassObject->TextFilter( \$text );

exit;

