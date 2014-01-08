#!/usr/bin/perl

use strict;

my $t = {
  AB_A =>  { A => 5000, B => 1250, AB => 3750, O => 0 },
  AB_AB => { A => 2500, B => 2500, AB => 5000, O => 0 },
  AB_B =>  { A => 1250, B => 5000, AB => 3750, O => 0 },
  AB_O =>  { A => 5000, B => 5000, AB => 0,    O => 0 },
  A_A =>   { A => 9375, B => 0,    AB => 0,    O => 625 }, 
  A_AB =>  { A => 5000, B => 1250, AB => 3750, O => 0 },
  A_B =>   { A => 1875, B => 1875, AB => 5625, O => 625 }, 
  A_O =>   { A => 7500, B => 0,    AB => 0,    O => 2500 }, 
  B_A =>   { A => 1875, B => 1875, AB => 5625, O => 625 }, 
  B_AB =>  { A => 1250, B => 5000, AB => 3750, O => 0 },
  B_B =>   { A => 0,    B => 9375, AB => 0,    O => 625 }, 
  B_O =>   { A => 0,    B => 7500, AB => 0,    O => 2500 }, 
  O_A =>   { A => 7500, B => 0,    AB => 0,    O => 2500 }, 
  O_AB =>  { A => 5000, B => 5000, AB => 0,    O => 0 },
  O_B =>   { A => 0,    B => 7500, AB => 0,    O => 2500 }, 
  O_O =>   { A => 0,    B => 0,    AB => 0,    O => 10000 }
};

my $deutsch = {
  O  => 0.41,
  A  => 0.43,
  B  => 0.11,
  AB => 0.05
};

my $aborigines = {
  O  => 0.61,
  A  => 0.39,
  B  => 0.0,
  AB => 0.0
};

my $peruaner = {
  O  => 0.00,
  A  => 0.00,
  B  => 0.00,
  AB => 1.00
};

#simulate("Deutsch",    $deutsch,    90);
#simulate("Aborigines", $aborigines, 90);
simulate("Peruaner",   $peruaner,   330);

sub simulate() {
   my $desc = shift;
   my $conf = shift;
   my $cycl = shift;

   print "\n\n== $desc ==\n";
   foreach (1 .. $cycl) {
      print_configuration($conf);
      $conf = generation($conf);
   }
}
sub print_configuration() {
   my $conf = shift;
   my $sum  = 0;

   # Korrektur des Rundungsfehlers:
   my $soll = 1 - $conf->{O} - $conf->{A} - $conf->{B};
   my $ist  = $conf->{AB};
   my $delta = $ist - $soll;
   $conf->{AB} = $soll;

   foreach my $i ("O", "A", "B", "AB") {
      printf("%2s: %6.2f%% ", $i, 100 * $conf->{$i});
      $sum += 100 * $conf->{$i};
   }
   print "(sum = $sum\%).";
   print " Aktuelles Delta: $delta\%." if ($delta);
   print "\n";

}

sub generation() {
   my $conf = shift;
   my $sum  = 0;
   my $next = {
        O  => 0.0,
        A  => 0.0,
        B  => 0.0,
        AB => 0.0
   };

   foreach my $father ("O", "A", "B", "AB") {
      foreach my $mother ("O", "A", "B", "AB") {
	 my $comb = "${father}_${mother}";
	 my $val  = $conf->{$father} * $conf->{$mother};
#	 print "> Elterntyp $comb hat ", $val * 100, "% Wahrscheinlichkeit.\n";

	 foreach my $child ("O", "A", "B", "AB") {
	    my $prob = $t->{$comb}->{$child} / 10000;

#	    print ">>  Ein Kind mit $child hat die Wahrscheinlichkeit ", $prob * 100, "%\n";

	    $next->{$child} += ($val * $prob);
	 }

#	 print "Nach der Berechnung der Nachkommen von $comb: ";


#	 print_configuration($next);
      }
   }
   return $next;
#   use Data::Dumper;
#   print Dumper($next);
}
