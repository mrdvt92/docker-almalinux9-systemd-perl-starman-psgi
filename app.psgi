#!/usr/bin/perl
use strict;
use warnings;
use DateTime qw{};
use Data::Dumper qw{Dumper};
use Plack::Builder qw{builder mount enable};
use Plack::Middleware::Expires qw{};
use Plack::Middleware::Session::Cookie qw{};
use Plack::Middleware::Favicon_Simple;
use Plack::Middleware::Method_Allow;

$Data::Dumper::Sortkeys = 1;
$Data::Dumper::Terse    = 1;
my $GLOBAL              = 0;

my $app = sub {
    my $env     = shift;
    my $session = $env->{'psgix.session'};
    $GLOBAL++;
    $session->{'counter'}++;
    $session->{'init'} ||= DateTime->now->datetime;

    return [
        200,
        [ 'Content-Type' => 'text/plain' ],
        [
          sprintf("Cookie Session Counter: %s\nProcess ID: %s\nGlobal Counter: %s\n\n", $session->{'counter'}, $$, $GLOBAL),
          Dumper($env),
        ],
    ];
};

builder {
  enable 'Method_Allow', allow=>['GET'];
  enable 'Favicon_Simple';
  enable 'Session::Cookie', secret => 'b8a94f58-6bd9-11eb-9308-0011955df2b8';
  $app;
};
