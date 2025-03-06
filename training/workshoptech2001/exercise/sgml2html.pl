#!/l/local/bin/perl

use strict;

## --------------------------------------------------
## This script converts a simple sgml text file containing
## a memo into displayable html.
## It reads in a file into one long string and then runs
## regexp replacements to "filter" sgml tags with html tags.
## --------------------------------------------------

## --------------------------------------------------
## get input and output file names from command line
## --------------------------------------------------

my ( $inputFile, $outputFile ) = @ARGV;

## --------------------------------------------------
## Read in SGML file into one string
## --------------------------------------------------

my $gInput = &InputFileToString( $inputFile );

&FilterSGML( \$gInput );

&OutputToFile( \$gInput, $outputFile );

exit;



## --------------------------------------------------
## input all text of input file into string
## --------------------------------------------------
sub InputFileToString
{
    my $inputFile = shift;
    open ( INFILE, "<$inputFile" ) || die;
    my ( $line, $s );

    while ( $line = <INFILE> )
    {
        $s .= $line;
    }
    close ( INFILE );

    return $s;
}


## --------------------------------------------------
## Filter the string and output to a file
## --------------------------------------------------
sub FilterSGML
{
    my $sRef = shift;

    my ( $newS, $header, $title );

    ## rip out header and grab appropriate title from it
    if ( $$sRef =~ s,<HEADER.*?>(.*?)</HEADER>,,s )
    {
        $header = $1;

        # grab only the TITLE from the FILEDESC's TITLESTMT
        if ( $header =~ m,<TITLE>(.*?)</TITLE>,s )
        {
            $title = $1;
        }
    }


    ## now, filter tags for whole file
    $$sRef =~ s,</?DLPSTEXTCLASS.*?>,,gs;
    $$sRef =~ s,</?BODY.*?>,,gs;
    $$sRef =~ s,</?TEXT.*?>,,gs;

    $$sRef =~ s,<DIV2.*?>,<blockquote>\n,gs;
    $$sRef =~ s,</DIV2>,</blockquote>\n,gs;

    $$sRef =~ s,<DIVINFO.*?>,<br>,gs;
    $$sRef =~ s,</?DIVINFO>,,gs;

    $$sRef =~ s,<DIV1.*?>,,gs;
    $$sRef =~ s,</DIV1>,,gs;

    $$sRef =~ s,<AUTHOR.*?>(.*?)</AUTHOR>,<b>Author</b>: $1<br>\n,gs;
    $$sRef =~ s,</?FIRSTL>,,gs;
    $$sRef =~ s,<L N=\"(.*?)\">,<i>$1</i>: ,gs;
    $$sRef =~ s,</L>,<br>\n,gs;
    $$sRef =~ s,<HEAD.*?>(.*?)</HEAD>,<b>Head</b>: $1</br>\n,gs;


    $$sRef = qq{<html>\n<head>\n<title>$title</title>\n</head>\n\n} .
        qq{<body>\n} . 
            qq{<h1>Title: $title</h1>\n} .
                $$sRef . qq{</body>\n</html>\n};

}



## --------------------------------------------------
## Output filtered string to a file
## --------------------------------------------------
sub OutputToFile
{
    my ( $sRef, $outputFile ) = @_;

    open ( OUTFILE, ">$outputFile" ) || die;

    print OUTFILE $$sRef;

    close ( OUTFILE );
}


__END__;




