README:
pagliere 20040806

1) on dev-linux.umdl.umich.edu, in /l1/web/d/dlxs/training/workshopYYYYMM, lives the web site for the
   DLXS Workshop for the date YYYYMM.
2) pagliere maintains a Dreamweaver instance of the site, checking for broken links and such, and
   updating the DW instance with others' changes.
3) pagliere will make changes to his own areas of the workshop web site in DW and use DW to ftp
   those changes to the machine and directory named in #1 above.
4) others will make changes to their areas of the workshop web site using any tool they want,
   directly in the directory named in #1 above. 
5) as needed, pagliere will synchronize others' changes into the DW instance and then
   use rdist (the RDist file in dev-linux.umdl.umich.edu:/l1/web/d/dlxs/) to push these changes
   to dlps8.umdl.umich.edu where the public version of the web site lives.