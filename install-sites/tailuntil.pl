#!/bin/perl
$re = shift;
$file = shift;
open (LOGFILE, $file) or die "could not open file reason $! \n";
for (;;) {
   seek(LOGFILE,0,1);  ### clear OF condition 
   for ($curpos = tell(LOGFILE); <LOGFILE>; $curpos = tell(LOGFILE)) {
        print;
        exit 0 if /$re/;
   }
   sleep 1;
   seek(LOGFILE,$curpos,0); ### Setting cursor at the EOF
}
