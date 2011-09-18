use strict;
use warnings;

use Plack::Builder;
use Plack::Response;
use Plack::Request;
use JSON;

use Client::Runner;
use Include::Enviroment qw(enviroment request response response_json);
use Game::Dispatcher;

use Data::Dumper;


sub parse_request {
    my ($env) = @_;

    #set global response, request and env objects
    enviroment($env);
    response(Plack::Response->new(200));
    response()->content_type('text/javascript');
    request(Plack::Request->new($env));

    my $json = request()->raw_body();

    my $data = '';
    eval {
        $data = from_json($json)
    };
    if ($@ or !$data->{action}) {
        response_json({
            result => 'badJson',
            description => $@ ? $@ : 'no action field'});
    } else {
        Game::Dispatcher::process_request($data);
    }

    response()->finalize();
};

builder {
    # Include PSGI middleware here

    mount "/" => \&Client::Runner::run;
    mount "/engine" => \&parse_request;
};

__END__

=head1 NAME

app.psgi - разбор полученного в запросе json, загрузка конфигурации, соединение с базой данных, инициализация веб-сессии(поиск sid-а в базе данных)










