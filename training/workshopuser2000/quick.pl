#!/l/local/bin/perl -i
 
while (<>) {
    s,<A HREF="../cic-workshop.html#schedule">,<A HREF="../workshop-user-2000.html">,g;
    print;
}

