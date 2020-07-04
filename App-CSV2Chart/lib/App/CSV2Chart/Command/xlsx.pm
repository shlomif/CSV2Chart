package App::CSV2Chart::Command::xlsx;

use strict;
use warnings;

use App::CSV2Chart -command;
use App::CSV2Chart::API::ToXLSX ();

sub description
{
    return "Generate .xlsx";
}

sub abstract
{
    return shift->description();
}

sub opt_spec
{
    return @{ App::CSV2Chart::API::ToXLSX::_to_xlsx_common_opt_spec() };
}

sub execute
{
    my ( $self, $opt, $args ) = @_;

    my $fn  = $opt->{output};
    my $exe = $opt->{exec} // [];

    my $fh = \*STDIN;

    App::CSV2Chart::API::ToXLSX::csv_to_xlsx(
        {
            input_fh   => $fh,
            output_fn  => $fn,
            height     => $opt->{height},
            width      => $opt->{width},
            title      => $opt->{title},
            chart_type => $opt->{'chart_type'},
        }
    );
    if (@$exe)
    {
        system( @$exe, $fn );
    }
    return;
}

1;

__END__

=head1 NAME

csv2chart xlsx - generate an .xlsx file with an embedded chart from CSV data

=cut
