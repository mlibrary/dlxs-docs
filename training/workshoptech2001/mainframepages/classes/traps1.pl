# **********************************************************************
#
# In textclass.cfg
#
# **********************************************************************

# Package is a place where one might keep routines that are very
# specific to a local implementation. Then follow one or more routines
# in that package that might be needed.

$gLocalPackageFile = 'DlpsLocalUtils.pm';
$gIdResolverTrap   = 'DlpsIdResolver';


# **********************************************************************
#
# In text-idx
#
# **********************************************************************

# import any routines in the Local Utils file( mostly traps)
# this must be after requiring of 'textclass.cfg' so as to set
#   the value of $gLocalPackageFile
$gLocalPackageFile = $ENV{'DLXSROOT'} . $gScriptDir . $gLocalPackageFile;
ASSERT( ( -e $gLocalPackageFile ),
        qq{File does not exist: $gLocalPackageFile} );
require $gLocalPackageFile;

# **********************************************************************
#
# In DlpsUtils.pm
#
# **********************************************************************

sub RunTrap
{
    my ( $routineCodeRef, @params ) = @_;
    {
        if ( ref( $routineCodeRef ) eq 'CODE' )
        {
            &{$routineCodeRef}( @params );
        }
    }

}

# **********************************************************************
#
# Trap subroutine in DlpsLocalUtils.pm
#
# **********************************************************************

$DlpsIdResolver = sub
{
    my ( $cgi, $cio, $docroot, $dso, $htmlPageRef ) = @_;

    [ etc.]


# **********************************************************************
#
# Called in pageviewer-idx
#
# **********************************************************************

sub CheckIdMatches
{
    my ( $cgi, $cio, $docroot, $dso ) = @_;

    # check for multiple matches of idno
    if ( $cgi->param( 'idno' ) )
    {
        # no strict is needed to invoke the subroutine reference.
        # This in turn is needed to be able to pass by reference the code
        # to the generic RunTrap in DlpsUtils
        no strict 'refs';

        my $htmlPage = &GetHtmlTemplateText( 
                         &CgiToHtmlTemplate( $cgi, 'picklist', %gPVHtmlTemplates ) );

        &DlpsUtils::RunTrap( $$gIdResolverTrap, $cgi, $cio, $docroot, $dso, \$htmlPage );
    }
}
