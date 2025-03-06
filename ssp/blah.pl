#!/usr/local/bin/perl

while (<>) {
    s,</?tr>,,g;
    @cols = split(/<\/td><td>/, $_);
    foreach $i (0..$#cols) {
	$cols[$i] =~ s,</?td>,,g;
	# print($cols[$i], "\t");
	$rows{($i + 1)} .= qq{<td>$cols[$i]</td>};
    }
    # print("\n");
}

foreach $row (sort {$a <=> $b} (keys (%rows))) {
    $rows{$row} =~ s,\n,,g;
    print("<tr>", $rows{$row}, "</tr>\n");
}

