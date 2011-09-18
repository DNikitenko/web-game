package Include::Enviroment;

use strict;
use warnings;

use JSON;
use Plack::Response;
use Plack::Request;

use Exporter::Easy (
    OK => [ qw(enviroment request response response_json) ],
);

my ($enviroment, $request, $response);

sub enviroment {
    if (@_) {
        $enviroment = $_[0]
    }
    $enviroment
}

sub request {
    if (@_) {
        $request = $_[0]
    }
    $request;
}

sub response {
    if (@_) {
        $response = $_[0];
    }
    $response;
}

sub response_json {
    my ($text, $params) = @_;
    $params->{pretty} = 1;
    $response->body(to_json($text, $params))
}

1

__END__

=head1 NAME

Include::Enviroment - глобальные данные: запрос(Plack::Request), ответ(Plack::Response), окружение(%env), соединиение с БД