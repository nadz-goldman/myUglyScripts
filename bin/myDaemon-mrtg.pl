#!/mnt/HD/HD_a2/ffp/bin/perl

use strict;
use warnings;
use POSIX qw(setsid mktime);
use IO::Handle;
use Cwd;
use File::Spec::Functions;
use FindBin;
use lib "$FindBin::Bin/../lib";


my $myDaemonName = "myDaemon-mrtg";

my $debug  = 0;   # ne vklyuchat - rabotaet kak govno
my $dir    = "/mnt/HD/HD_a2/myScripts";
my $dirBin = $dir."/bin/";
my $dirTmp = $dir."/tmp/";
my $dirLog = $dir."/log/";

my $lockFile  = $dir.$myDaemonName."lock";
my $pidFile   = $dirLog.$myDaemonName.".pid";
my $logFile   = $dirLog.$myDaemonName."-error.log";
my $debFile   = $dirLog.$myDaemonName."-debug.log";
my $testFile  = $dirTmp.$myDaemonName."-test.log";
my $pid;
my $daemon;
my $cmd = "";
my @pids;

my $logLimit = 10485760;   # log file limit in bytes (here is 10 Mb)
my $fSize = "";

my $sec  = 0;
my $min  = 0;
my $hour = 0;
my $day  = 10;
my $mon  = 2 - 1;
my $year = 2010 - 1900;
my $wday = 0;
my $yday = 0;

my $unixtime = mktime( $sec , $min , $hour , $day , $mon , $year , $wday , $yday );
my $time = localtime( $unixtime );

################################################################################################

chdir $dir;

open DF , '>>' , $debFile;

$cmd = $ARGV[0];
chomp $cmd if defined $cmd;
usage() if !defined $cmd || length $cmd == 0;

if( $cmd eq "start" ){ start(); }
elsif( $cmd eq "stop" ){ stop(); }
elsif( $cmd eq "status" ){ status(); }
elsif( $cmd eq "help" ){ help(); }
elsif( $cmd eq "restart" ){ restart(); }
else{ usage(); }

close DF;

exit 1;

################################################################################################

sub usage{
    print "\nUsage:\n";
    print "Daemon rules: start || stop || restart || status || help\n";
    exit 0;
}


sub start{
    print DF "$time\tStartig daemon\n" if $debug;
    if ( -e $pidFile ) { print "Pid file exists: $pidFile\n"; exit 2; }
    print "PID: ".POSIX::getpid()."\n";
    print "$time\t debug is $debug\nWorking from dir is $dirBin\nPid is $pidFile\nTest file: $testFile\n" if $debug;

#    open STDIN,  '/dev/null'                   or die "Can't read /dev/null: $!";
    open STDOUT, '>>' , $logFile                or die "Can't write to $logFile: $!\n";
    open STDERR, '>>' , $logFile                or die "Can't read $logFile: $!\n";

    chdir $dirBin               or die "Can't chdir to $dirBin $!\n";
    defined( $pid = fork )      or die "Can't fork: $!\n";
    exit if $pid;
    POSIX::setsid() or die "Can't start new session\n";
    $0 = 'myDaemon-mrtg';
    umask 0;

    open PID , '>' , $pidFile or die "Can't open $pidFile\n";
    print PID $$;
    close PID;

	open LF , '>>' , $logFile;
	my $q = `/bin/date`;
	chomp $q;
	print LF "$q Daemon started\n";

	my $stat = "";

	while( 1 ){
		my $r = `/bin/date`;
		$| = 1;
		sleep 360;
		my $exec = `/mnt/HD/HD_a2/myScripts/bin/stats/run_mrtg.sh`;
	}
	close LF;
}

sub stop{
    print DF "$time\tTrying to kill daemon\n" if $debug;
    if ( !-e $pidFile ) { print "Pid file not exists: $pidFile\n"; }
    open PID , '<' , $pidFile ; # or die "Can't open $pidFile\n";
    @pids = <PID>;
    close PID;
    kill 'HUP' , @pids;
    print "Killed: @pids \n";
    unlink $pidFile;
    print DF "$time\tDaemon with pids @pids killed\n" if $debug;

	open LF , '>>' , $logFile;
	my $q = `/bin/date`;
	chomp $q;
	print LF "$q Daemon stopped\n";
	close LF;
}


sub status{
    print DF "$time\tGetting status" if $debug;
    open PID , '<' , $pidFile or die "Daemon not running, because can't open $pidFile\n";
    @pids = <PID>;
    close PID;
    print "Daemon seems running, pids: @pids \n";
    print DF "$time\tDaemon running with pids: @pids killed\n" if $debug;
}

sub restart{
	stop();
	start();
}

sub FiSi{
	my $size = -s $_[0];
	return $size;
}
