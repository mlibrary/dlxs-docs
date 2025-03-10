validateeach.csh

 
      1  #!/bin/csh
      2
      3  foreach file ( $DLXSROOT/prep/s/samplefa/data/*.xml )
      4  echo "working on $file"
      5  perl -p -e 's,&lt;\!DOCTYPE.*?\&gt;,,s;' $file  &gt; $file.tmp
      6  onsgmls -s -f $file.err $DLXSROOT/misc/sgml/xml.dcl DLXSROOT/prep/s/samplefa/samplefa.text.inp $file.tmp
      7  rm $file.tmp
      8  end
      9
     10
     11  find $DLXSROOT/prep/s/samplefa/data -type f -size 0 -prune -exec rm {} \;
     12

* Line 5 creates a copy of the EAD with a ".tmp" extension after it removes the doctype declaration
* Line 6 runs onsgmls to validate the copy using the doctype in samplefa.text.inp
** -s suppresses output. That means instead of getting a parse tree, we just get any errors
** -f $file.err tells onsgmls to write errors to a file with the �.err� extension
** $DLXSROOT/misc/sgml/xml.dcl is an SGML Declaration for valid XML documents.
** $DLXSROOT/prep/s/samplefa/samplefa.text.inp is a replacement for the deleted document type declaration. It points to a copy of the EAD2002 dtd and adds several entities. These are not needed and the next version of DLXS will not include these entities. However, if you have custom entities such as a logo in your finding aids, you may want to declare them in your customized version of samplefa.txt.imp and samplefa.xml.imp.
** Note: The next version of DLXS will add the -wxml flag which tells onsgmls to use xml warnings (instead of sgml): "onsgmls -wxml -s -f $file.err $DLXSROOT/misc/sgml/xml.dcl DLXSROOT/prep/s/samplefa/samplefa.text.inp $file.tmp"
* line 7 removes the temporary files
* line 11 removes 0 byte files (any *err files that are completely empty)

samplefa.text.inp

 &lt;!DOCTYPE ead SYSTEM "/l1/release/13/misc/sgml/ead.dtd" [<br />&lt;!ENTITY gt "&amp;gt;" &gt;<br />&lt;!ENTITY lt "&amp;lt;" &gt;<br />&lt;!ENTITY mdash "&amp;mdash;" &gt;<br />&lt;!ENTITY amp "&amp;amp;" &gt;<br />]&gt;<br />
 Note:The character entities are not needed and will be removed in next release of FindaidClass
 However, if you have other entities in your DTD you should put them in samplefa.text.inp  as well as in
 samplefa.xml.inp.
 
 See http://openjade.sourceforge.net/doc-1.5.1/nsgmls.htm  for more info on onsgmls
 
 
 
