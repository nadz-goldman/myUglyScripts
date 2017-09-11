package mysql;

##
## Easy and ugly perl-package
## for handlind mysql
##

use DBI;
use strict;
use warnings;
use Exporter;
our @ISA = qw( Exporter );
our @EXPORT = qw( _connect _disconnect checkMysql checkTable $dbh );
#our @EXPORT_OK = qw( $dbh );


my $sql_user		= $ENV{SQL_USER};
my $sql_password	= $ENV{SQL_PASSWD};
my $sql_base		= $ENV{SQL_BASE};
my $sql_host		= $ENV{SQL_HOST};
my $debug = 0;
my $sth;
our $dbh;
#our $sth;
#my $DBD;

if( ! ( $sql_host ))		{ $sql_host="HO.ST.IP.ADDRESS"; }
if( ! ( $sql_user ))		{ $sql_user="SQL-USER"; }
if( ! ( $sql_password ))	{ $sql_password="SUPER-PASSWORD"; }
if( ! ( $sql_base ))		{ $sql_base="SQL-BASE"; }

print "User:$sql_user\nPassword:$sql_password\n" if $debug == 1;


sub _connect{
    my( $u , $p ) = @_;

    $sql_user		= $u if $u;
    $sql_password	= $p if $p;

    print "CONNECT\nUser:$sql_user\nPassword:$sql_password\n" if $debug == 1;

    $dbh =  DBI->connect( "DBI:mysql:".$sql_base.";host=".$sql_host."" , $sql_user , $sql_password );
    $dbh -> { RaiseError } = 1;
}

sub _disconnect{
    print "DISCONNECT\n" if $debug == 1;
    if( $sth ){ $sth->finish(); }
    $dbh->disconnect or warn $dbh->errstr;
}

sub checkTable{
    my ( $i , $t );
    $sth = $dbh -> prepare( "SELECT COUNT(*) FROM `".$_[0]."`;" );
    print "CHECK TABLE:\nSELECT COUNT(*) FROM `".$_[0]."`;\n" if( $debug );
    $sth -> execute || die "Can not do sql query\n";
    while( $i = $sth -> fetchrow ){
	$t = $i;
    }
    return $t;
}

sub checkMysql{
    if( !( _connect ) ){ die "MySQL connection error\n"; }
    else { _disconnect(); }
    return 1;
}

1;
