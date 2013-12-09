#!/usr/bin/perl
`sed 2d /mnt/vcenter_audit/log.txt > /tmp/log`;
open(InFile,"/tmp/log") || die;
print '
<STYLE>
  TABLE,TR,TD{border:1px solid black;border-collapse:collapse;white-space: nowrap; width:100%;}
  TR{background-color:#E0E6FA;}
  TD{background-color:#F6F8FE;}
  TR,TD{text-align:left;vertical-align:middle}
  TR{font:bold 17px "sans-serif"}
  TD{font:normal 15px "sans-serif"}
th {
 background: #ffaaaa;
 border: 1px #0000ff solid; /* стиль рамки заголовков */
 padding: 0.2em; 
}
</STYLE>
';

$lineCount=0;

print '<table>';

while ($line = <InFile>)
{
	$line =~ s/^/<TR><TD>$lineCount<\/TD><TD>/g;
        $line =~ s/;/<\/TD><TD>/g ;
	$line =~ s/$/<\/TD><\/TR>/g;

	print $line;
	
	print " \n";
	
	$lineCount++;
}
print '<table>';

close ( InFile );
