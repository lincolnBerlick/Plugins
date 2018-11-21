#plugin para criar contas de ragnarok no novo site warpportal; falta gerador de nomes.

#!/usr/bin/perl -w
use strict;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI ':standard';
use WWW::Mechanize;
#use WWW::Mechanize::Chrome;
#use WWW::Mechanize::PhantomJS;
use Data::Dumper;




my $outfile = "out2.html";
my $username = 'loginhere';
my $password = 'senhahere';
my $url = "https://www.warpportalbr.com/account/login.aspx";



my $mech = WWW::Mechanize->new();;
$mech -> cookie_jar(HTTP::Cookies->new());




$mech->get($url);


my $result = $mech->submit_form(
								form_name => 0, #name of the form
								#instead of form name you can specify
								#form_number => 1
								fields      =>{
											 'ctl00$ContentPlaceHolder1$email'    => $username, # 
											 'ctl00$ContentPlaceHolder1$password'    => $password,
								}
								,button    => 'ctl00$ContentPlaceHolder1$btnSubmit' 
								);


print "login com sucesso \n\n\n\n";

#print "Content-type: text/html\n\n";


$mech->follow_link( url => 'https://www.warpportalbr.com/account/accountinformation.aspx');
print "redirecionado para accountinformatioin \n\n\n\n";


$mech->click_button(name => 'ctl00$ContentPlaceHolder1$AddGameButton');
print "redirecionado para infogames \n\n\n\n";


$mech->follow_link( url => 'addgame.aspx?t=ro1');
print "redirecionado para criar accounts \n\n\n\n";








$mech->set_fields(

				 'ctl00$ContentPlaceHolder1$usernameInput'    => 'servoppp1', # 
				 'ctl00$ContentPlaceHolder1$passwordInput'    => 'novidade@',
				 'ctl00$ContentPlaceHolder1$rePasswordInput'  => 'novidade@',
				 'ctl00$ContentPlaceHolder1$gender'    => 'Masculino',
				 'ctl00$ContentPlaceHolder1$agreement' => 'on',

				);

$mech->click_button(name =>'ctl00$ContentPlaceHolder1$RegistrationButton');


$output_page = $mech->content();




#print $output_page;
open(OUTFILE, ">$outfile");

binmode(OUTFILE, ":utf8");
print OUTFILE "$output_page";
close(OUTFILE);
