#!/usr/bin/perl
#
# Extract source CTD URL from README.md's
#
# To minimise network loads to the CCHDO server, use sparingly.
#
use strict;
use WWW::Mechanize;

my @sections = (
    'A01', 'A02', 'A03', 'A05', 'A10', 'A12', 'A13', 'A16-A23', 'A20', 'A22', '75N',
    'I01', 'I02', 'I03-I04', 'I05', 'I06S', 'I07', 'I08N', 'I08S-I09N', 'I09S', 'I10', 'IR06', 'IR06E', 'IR06-I10',
    'P01', 'P02', 'P03', 'P04', 'P06', 'P09', 'P10', 'P11', 'P13', 'P14', 'P15', 'P16', 'P17', 'P17E', 'P18', 'P21',
    'S04I', 'S04P', 'SR01', 'SR03', 'SR04',
);

foreach my $dir (@sections) {
    open(my $fh, '<', "$dir/README.md") or die "$!: $dir/README.md";
    while (<$fh>) {
        if (m'cchdo.ucsd.edu/cruise') {
            if ($_ =~ m/^+.*\((https:\/\/cchdo\.ucsd\.edu\/cruise\/.*)\)/) {
                my $mech = WWW::Mechanize->new(autocheck => 1);
                $mech->get("$1");
                my $link = $mech->find_link(text_regex => qr/ct1.zip/);
                my $abs;
                if (defined $link) {
                    $abs = $link->url_abs;
                } else {
                    $abs = 'UNDEFINED';
                }
                print "$dir: $abs\n";
            }
        }
    }
    close ($fh)
}







