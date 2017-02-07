#!/ffp/bin/perl  -w
#===============================================================================
#
#         FILE:  check_port.pl
#
#        USAGE:  check_port.pl -p <port> -h <host> (-c <critical> -w <warning> -v)
#
#  DESCRIPTION:  tests to see if the port is responding and can display timing
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Tim Pretlove
#      VERSION:  1.3
#      CREATED:  04/12/09 13:57:23
#     REVISION:  ---
#      LICENCE:  GNU
#
#       AUTHOR:  Jim Sander jim.sander@jdsmedia.net
#      VERSION:  1.2
#     MODIFIED:  10-04-2014 16:00
#         BUGS:  Socket::pack_sockaddr_in, length is 0 error for unresolvable hostnames
#        NOTES:  Fixed; now exits with '3', status UNKNOWN, and 'host lookup failed'
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#===============================================================================

use strict;
use warnings;
use Socket;
use Getopt::Long;
use Time::HiRes qw(gettimeofday tv_interval);

my ($timeout, $host, $portnum, $verbose);
GetOptions(
    'timeout=s'     => \$timeout,
    'host=s'        => \$host,
    'port=s'        => \$portnum,
    'verbose'       => \$verbose) or HELP_MESSAGE();

sub testport {
	my ($host,$port,$protocol,$timeout) = @_;
    my $startsec;
    my $elapsed = 0;
	if (!defined $timeout) { $timeout = 10 }
	if (!defined $protocol) { $protocol = "tcp" }
	my $proto = getprotobyname($protocol);
	my $iaddr = inet_aton($host);
	if ( !defined $iaddr ){ return 3,$elapsed; }
	my $paddr = sockaddr_in($port, $iaddr);
	$startsec = [gettimeofday()];
	socket(SOCKET, PF_INET, SOCK_STREAM, $proto) or die "socket: $!";
	eval {
		local $SIG{ALRM} = sub { die "timeout" };
		alarm($timeout);
		connect(SOCKET, $paddr) or error();
		alarm(0);
	};
	if ($@) {
		close SOCKET || die "close: $!";
		$elapsed = tv_interval ($startsec, [gettimeofday]);
		return "1",$elapsed;
	} else {
		close SOCKET || die "close: $!";
		$elapsed = tv_interval ($startsec, [gettimeofday]);
		return "0",$elapsed;
	}
}
sub HELP_MESSAGE {
	print "$0 -p <port> -h <host> \n"; 
	print "\t -p <port> # port number to examine\n";
	print "\t -h <hostname> # hostname or ip address to contact\n";
	print "\te.g $0 -p 80 -h www.google.com \n";
    exit(4);
}

sub test {
    my ($host,$portnum,$timeout) = @_;
    my $proto = "tcp";
	my ($rc,$elapsed) = testport($host,$portnum,$proto,$timeout); 
	if ($rc == 0) {
		return $rc,$elapsed;
	} else {
		return 2,$elapsed;
	}
}

unless ((defined $portnum) && (defined $host)) { 
	HELP_MESSAGE();
	exit 1;
}

my @mess = qw(OK WARNING CRITICAL UNKNOWN);
my @mess2 = ("GOOD","SLOW","BAD","host lookup failed");
my ($rc,$elapsed) = test($host,$portnum,$timeout);
print "$host $portnum $mess2[$rc]\n";

exit($rc);
