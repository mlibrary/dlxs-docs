use HTML::WikiConverter;

my $file ="fc_char.html";

my $wc = new HTML::WikiConverter( dialect => 'MediaWiki' );
print $wc->html2wiki ( file =>$file);
