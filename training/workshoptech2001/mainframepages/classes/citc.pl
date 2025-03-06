package CollsInfo::CITC;

# © 2000, The Regents of The University of Michigan, All Rights Reserved
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject
# to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

BEGIN
{
    # enable strict under development
    if ( $ENV{'DLPS_DEV'} )
    {
        require "strict.pm";
        strict::import();
    }
}


BEGIN
{
    unshift ( @INC, '.' );
}

use CollsInfo;
use vars qw( @ISA );


# Subclass of CollsInfo.pm module
@ISA = qw( CollsInfo );

use DlpsUtils;

# ----------------------------------------------------------------------
#
# This module is the TextClass subclass of  CollsInfo object (which see)
#
# The structure of this object is:
# CollsInfo Object->
#   (a hash 'colls' for all authorized collections
#     {'colls'}{ $collid }  =  TextClass Object (or subclass object of TextClass)
#
#     {'authcollcount'}  = number of authorized collections
#     {'authtextscount'} = number of texts in authorized collections
#     {'reqcollcount'}   = number of requested collections
#     {'reqtextscount'}  = number of textsin requested collections
#
# This subclass adds the following additional member data
#
#     {'authcommontermsearchregions'}  = ref to list of regions, common to
#          all authorized collections, to be used in region restriction
#          pull downs for term searches (e.g., simple, prox type searches)
#     {'authcommontermregionregions'}  = ref to list of regions, common to
#          all authorized collections, to be used in region restriction
#          pull downs for region searches (e.g., boolean type searches)
#     {'reqcommontermsearchregions'}  = ref to list of regions, common to
#          all requested collections, to be used in region restriction
#          pull downs for term searches (e.g., simple, prox type searches)
#     {'reqcommontermregionregions'}  = ref to list of regions, common to
#          all requested collections, to be used in region restriction
#          pull downs for region searches (e.g., boolean type searches)
#     'reqcommongenres'}    = ref to list of genres common to all requested collections
#     'reqcommongenders'}   = ref to list of genders common to all requested collections
#     'reqcommonperiods'}   = ref to list of periods common to all requested collections
#     'reqcommonlanguages'} = ref to list of languages common to all requested collections
#
# ----------------------------------------------------------------------

# **********************************************************************
# NAME      : new
# PURPOSE   : create a CollsInfo::CITC object
# CALLED BY : main
# CALLS     : _initialize
# INPUT     : text file with delimted DB, ref to array of permitted collections
# RETURNS   : self object reference
# NOTES     :
# **********************************************************************

sub new
{
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->SUPER::_initialize( @_ );
    
    $self->_initialize( );
    
    return $self;
}


# **********************************************************************
# NAME      : _initialize
# PURPOSE   : to populate the CollsInfo object (eventually this should be
#             a call through DBI to a database (either tab-delimited flat
#             file or other) rather than parsing the file itself
#             See the other, commented out intialized sub below.
# CALLED BY : $self->new
# CALLS     :
# INPUT     : tab-delimted file, ref to array of permitted collections
# RETURNS   : NONE
# NOTES     : adds collection info to object for just those collections
#             permitted;
#             ** eventually this should be a DBI based database access, but
#             as of now 2000-03-14 22:57:21 EST we can't get DBI::CSV to
#             work on current development machine;
#             so, simply parsing my own tab-delimted text file.
# **********************************************************************

sub _initialize
{
    my $self = shift;
    
    my ( @authCollsCommonTermSearchRegions, @authCollsCommonRegionSearchRegions,
         @reqCollsCommonTermSearchRegions, @reqCollsCommonRegionSearchRegions,
         @reqCollsCommonGenres, @reqCollsCommonGenders,
         @reqCollsCommonPeriods, @reqCollsCommonLanguages,
       );
    
    # this will eventually hold the lowest value of all the collections' LEL values
    # set high now and compare all incoming to it.
    my $lowestLel = 999;
    
    # if the line read is in the permitted collections (those in @$rColls), add to object
    foreach my $collid ( $self->GetCollIds() )
    {
        my @termsearch = $self->GetCollKeyInfo( $collid, 'termsearch' );
        my @regionsearch = $self->GetCollKeyInfo( $collid, 'regionsearch' );
        
        # Keep track of all search regions for authzd collections
        push ( @authCollsCommonTermSearchRegions, @termsearch );
        push ( @authCollsCommonRegionSearchRegions, @regionsearch );
        
        if ( $self->{'colls'}{$collid}{'requested'} )
        {
            # Keep track of all search regions for requested colls
            push ( @reqCollsCommonTermSearchRegions, @termsearch );
            push ( @reqCollsCommonRegionSearchRegions, @regionsearch );
            
            # Keep track of all genres, genders, periods and languages for requested colls
            my @genres = $self->GetCollKeyInfo( $collid, 'genres' );
            my @genders = $self->GetCollKeyInfo( $collid, 'genders' );
            my @periods = $self->GetCollKeyInfo( $collid, 'periods' );
            my @languages = $self->GetCollKeyInfo( $collid, 'languages' );
            
            push ( @reqCollsCommonGenres, @genres );
            push ( @reqCollsCommonGenders, @genders );
            push ( @reqCollsCommonPeriods, @periods );
            push ( @reqCollsCommonLanguages, @languages );
            
            # Keep track of the lowest LEL fo all requested collections
            if ( $self->{'colls'}{$collid}{'lel'} < $lowestLel )
            {
                $lowestLel = $self->{'colls'}{$collid}{'lel'};
            }
        }
    }
    
    
    # Save the "lowest common denominator" of all the LELs encountered
    $self->{'lowestlel'}  = $lowestLel;
    
    # Store away lists of common regions
    &DlpsUtils::SortUniquifyList( \@authCollsCommonTermSearchRegions );
    $self->{'authcommontermsearchregions'}  = \@authCollsCommonTermSearchRegions;
    &DlpsUtils::SortUniquifyList( \@authCollsCommonRegionSearchRegions );
    $self->{'authcommonregionsearchregions'}  = \@authCollsCommonRegionSearchRegions;
    
    &DlpsUtils::SortUniquifyList( \@reqCollsCommonTermSearchRegions );
    $self->{'reqcommontermsearchregions'}  = \@reqCollsCommonTermSearchRegions;
    &DlpsUtils::SortUniquifyList( \@reqCollsCommonRegionSearchRegions );
    $self->{'reqcommonregionsearchregions'}  = \@reqCollsCommonRegionSearchRegions;
    
    &DlpsUtils::SortUniquifyList( \@reqCollsCommonGenres );
    $self->{'reqcommongenres'}  = \@reqCollsCommonGenres;
    &DlpsUtils::SortUniquifyList( \@reqCollsCommonGenders );
    $self->{'reqcommongenders'}  = \@reqCollsCommonGenders;
    &DlpsUtils::SortUniquifyList( \@reqCollsCommonPeriods );
    $self->{'reqcommonperiods'}  = \@reqCollsCommonPeriods;
    &DlpsUtils::SortUniquifyList( \@reqCollsCommonLanguages );
    $self->{'reqcommonlanguages'}  = \@reqCollsCommonLanguages;
}


# ----------------------------------------------------------------------
# NAME         : GetLowestLel
# PURPOSE      : return the lowest of all the LEL values for requested colls
# CALLED BY    :
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : value of object's lowestLEL
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetLowestLel
{
    my $self = shift;
    return ( $self->{'lowestlel'} );
}


# ----------------------------------------------------------------------
# NAME         : GetAuthCollsCommonRegionsSearchRegions
# PURPOSE      : get sorted, uniq-ed list of all regionsearch region names
#                for all authorized collections
# CALLED BY    : ANY
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : array
# GLOBALS      : NONE
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetAuthCollsCommonRegionSearchRegions
{
    my $self = shift;
    my @returnArray = @{ $self->{'authcommonregionsearchregions'} };
    return @returnArray;
}

# ----------------------------------------------------------------------
# NAME         : GetAuthCollsCommonRegionsSearchRegions
# PURPOSE      : get sorted, uniq-ed list of all termsearch region names
#                for all authorized collections
# CALLED BY    : ANY
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : array
# GLOBALS      : NONE
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetAuthCollsCommonTermSearchRegions
{
    my $self = shift;
    my @returnArray = @{ $self->{'authcommontermsearchregions'} };
    return @returnArray;
}

# ----------------------------------------------------------------------
# NAME         : GetReqCollsCommonRegionsSearchRegions
# PURPOSE      : get sorted, uniq-ed list of all regionsearch region names
#                for all requested collections
# CALLED BY    : ANY
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : array
# GLOBALS      : NONE
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetReqCollsCommonRegionSearchRegions
{
    my $self = shift;
    my @returnArray = @{ $self->{'reqcommonregionsearchregions'} };
    return @returnArray;
}

# ----------------------------------------------------------------------
# NAME         : GetReqCollsCommonRegionsSearchRegions
# PURPOSE      : get sorted, uniq-ed list of all termsearch region names
#                for all requested collections
# CALLED BY    : ANY
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : array
# GLOBALS      : NONE
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetReqCollsCommonTermSearchRegions
{
    my $self = shift;
    my @returnArray = @{ $self->{'reqcommontermsearchregions'} };
    return @returnArray;
}

# ----------------------------------------------------------------------
# NAME         : GetReqCollsCommonGenres
# PURPOSE      : get sorted, uniq-ed list of all genres
#                for all requested collections
# CALLED BY    : ANY
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : array
# GLOBALS      : NONE
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetReqCollsCommonGenres
{
    my $self = shift;
    my @returnArray = @{ $self->{'reqcommongenres'} };
    return @returnArray;
}

# ----------------------------------------------------------------------
# NAME         : GetReqCollsCommonGenders
# PURPOSE      : get sorted, uniq-ed list of all genders
#                for all requested collections
# CALLED BY    : ANY
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : array
# GLOBALS      : NONE
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetReqCollsCommonGenders
{
    my $self = shift;
    my @returnArray = @{ $self->{'reqcommongenders'} };
    return @returnArray;
}


# ----------------------------------------------------------------------
# NAME         : GetReqCollsCommonPeriods
# PURPOSE      : get sorted, uniq-ed list of all periods
#                for all requested collections
# CALLED BY    : ANY
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : array
# GLOBALS      : NONE
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetReqCollsCommonPeriods
{
    my $self = shift;
    my @returnArray = @{ $self->{'reqcommonperiods'} };
    return @returnArray;
}

# ----------------------------------------------------------------------
# NAME         : GetReqCollsCommonPeriods
# PURPOSE      : get sorted, uniq-ed list of all periods
#                for all requested collections
# CALLED BY    : ANY
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : array
# GLOBALS      : NONE
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetReqCollsCommonLanguages
{
    my $self = shift;
    my @returnArray = @{ $self->{'reqcommonlanguages'} };
    return @returnArray;
}

# ----------------------------------------------------------------------
# NAME         : GetTotalRecords
# PURPOSE      : retrieve total records in all collections
# CALLED BY    : TextClassUtils::BuildTotalResultsString
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : total records in all collections
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetTotalRecords
{
    my $self = shift;
    return $self->{'totalrecords'};
}

# ----------------------------------------------------------------------
# NAME         : SetTotalRecords
# PURPOSE      : store total records in all collections
# CALLED BY    : $self->UpdateCrossCollNumbers
# CALLS        : NONE
# INPUT        : number of records
# RETURNS      : NONE
# SIDE-EFFECTS : sets data value in this object
# NOTES        :
# ----------------------------------------------------------------------

sub SetTotalRecords
{
    my $self = shift;
    my $n    = shift;

    $self->{'totalrecords'} = $n;
}

# ----------------------------------------------------------------------
# NAME         : GetTotalHits
# PURPOSE      : retrieve total matches in all collections
# CALLED BY    : TextClassUtils::BuildTotalResultsString
# CALLS        : NONE
# INPUT        : NONE
# RETURNS      : number of total matches
# SIDE-EFFECTS : NONE
# NOTES        :
# ----------------------------------------------------------------------

sub GetTotalHits
{
    my $self = shift;
    return $self->{'totalhits'};
}

# ----------------------------------------------------------------------
# NAME         : SetTotalHits
# PURPOSE      : store total matches in all collections
# CALLED BY    : $self->UpdateCrossCollNumbers
# CALLS        : NONE
# INPUT        : number
# RETURNS      : NONE
# SIDE-EFFECTS : sets data value in this CollsInfo object
# NOTES        :
# ----------------------------------------------------------------------

sub SetTotalHits
{
    my $self = shift;
    my $n    = shift;
    $self->{'totalhits'} = $n;
}




1;  # Truth
