#!/usr/bin/perl -w


##################################################
##
## Developed by Ilya Vasilyev aka Nadz Goldman
##
## Site: arviol.ru
##
##################################################

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use mysql;
use CGI::WebOut(1);


my ( @pairs , @data );
my ( %input , %hosts );
my ( $action , $query , $pair , $name , $value , $input , $sth );

if( $ENV{'REQUEST_METHOD'} eq 'GET' ){
    $query=$ENV{'QUERY_STRING'};
}
elsif( $ENV{'REQUEST_METHOD'} eq 'POST' ){
    sysread( STDIN , $query , $ENV{'CONTENT_LENGTH'});
}
if( ( !defined $query) || ( length $query == 0 ) ){ _showHeader(); }
@pairs = split( /&/ , $query );
foreach $pair ( @pairs ){
    ( $name , $value ) = split( /=/ , $pair );
    if( defined( $name )){
	if( !( defined( $value ))){
	    _showHeader(); next;
	}
    }
    $value =~ tr/+/ /;
    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex())/eg;
    $value =~ s/<!--(.| )*-->//g;
    $input{ $name } = $value;
    if( $value eq 'compare' ){
	_showHeader();_showCompare();
    }
    elsif( $value eq 'snmp' ){
	_showHeader();_showSNMP();
    }
    elsif( $value eq 'alive' ){
	_showHeader();_showAlive();
    }
}

sub _showHeader{
print "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">";
print "<html>";
print "<head>";
print "
    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
    <meta http-equiv=\"Content-Language\" content=\"ru\">
    <meta name=\"generator\" content=\"NG CMS\">
    <meta name=\"authors\" content=\"Ilya Vasilyev, ANZ Systems LTD copyright 2012\" />
    <meta name=\"copyright\" content=\"&copy; ANZ Systems\" />
    <META HTTP-EQUIV=\"CACHE-CONTROL\" CONTENT=\"NO-CACHE\">
    <META HTTP-EQUIV=\"PRAGMA\" CONTENT=\"NO-CACHE\">
    <META HTTP-EQUIV=\"EXPIRES\" CONTENT=\"Mon, 22 Jul 2002 11:12:01 GMT\">


<script type=\"text/javascript\">
<!--
function zebraTable () {
tables = document.getElementsByTagName(\"table\");
for (i = 0; i < tables.length; i++) {
    if (tables[i].className == \"zebra\") {
	tr = document.getElementsByTagName(\"tr\");
	    for (j = 0; j < tr.length; j++) {
		if (j%2) tr[j].className = \"odd\";
	    }
	}
    }
}
window.onload = zebraTable;
-->
</script>

<style type=\"text/css\">
body{
    background: #fafafa;
    text-align: left;
    align: center;
    font: 8pt sans-serif;
}
table.nav{
    align:center;
    padding:0px;
    margin:5px;
    border:1px dotted green;
}
table.nav td{
    border:1px dotted blue;
    text-align:left;
    vertical-align:top;
    font:8pt verdana;
    width:100px;
    vertical-align:middle;
    text-align:center;
}
table.nav table tr td{
    border:none;
    text-align:center;
    vertical-align:middle;
    padding:0px;
    margin:0px;
}
table.zebra{
    padding:5px;
    margin:5px;
    align:center;
}
table.zebra tbody tr.odd {
    background:#eee;
}
table.zebra td{
    border:1px dotted green;
    text-align:left;
    vertical-align:top;
    font:8pt verdana;
}
table.zebra thead td{
    font-weight:bold;
    text-align:center;
    vertical-align:middle;
    background:#bbb;
    color:#444;
}
div{
    float:left;
    position:relative;
    border:1px dotted black;
    margin:5px;
    padding:5px;
}
</style>
    ";
print "<title>SwiMan</title>";
print "</head>";
print "<body>";

    print "
        <table class=\"nav\">
            <tr>
                <td><a href=\"?action=snmp\">SNMP</a></td>
                <td><a href=\"?action=compare\">COMPARE</a></td>
                <td><a href=\"?action=alive\">ALIVE HOSTS</a></td>
            </tr>
        </table>
    ";
}

#############################
### MAIN
#############################

print "</body>";
