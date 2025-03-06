
package TextClass;


sub TextFilter
{
    my $self = shift;
    my ( $sRef ) = @_;

    # Make the author BIG, BIG, BIG
    $$sRef =~ s,(Author\:.*?),<font size=10>$1</font>,gs;

    my ( $authorName ) = m,Author:(.*?),;

    my $info = $self->GetSpecialAuthorInfo( $authorName );

    # concatenate special info
    $$sRef .= $info;

    return $results = $$sRef;
}

# Empty (Abstract) base class method
sub GetSpecialAuthorInfo
{
    my $self = shift;  # not really required here

    return "";
}



package SomeSubclass;

use TextClass ();

use vars qw( @ISA );
@ISA = qw( TextClass );

sub TextFilter
{
    my $self = shift;
    my ( $sRef ) = @_;

    my $results = $self->SUPER::TextFilter( $sRef );

    return $results;
}

# Implement Abstract Base Class method because this
# is a collection that supports this data
sub GetSpecialAuthorInfo
{
    my $self = shift;  # not really required here

    my $author = shift;
    
    my $info = &GetAuthorInfo( $author );

    &Htmlize( \$info );

    return $info;    
}




1;



#!/l/local/bin/perl

use TextClass;
use SomeSubclass;  # if compile time binding


require "SomeSubclass.pm"; # if run time binding


my $subclassObject = SomeSubclass->new( $collid );

my $text = 'Author: Phil Farber';


$subclassObject->TextFilter( \$text );

exit;

