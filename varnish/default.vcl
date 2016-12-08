vcl 4.0;

backend default {
    .host = "upstream";
    .port = "8000";
}

sub vcl_backend_error {
    set beresp.http.Content-Type = "text/html; charset=utf-8";
    if (beresp.status == 503) { # Maintenance
        synthetic(std.fileread("/var/www/errors/503.html"));
    } else {                    # Error
        synthetic(std.fileread("/var/www/errors/500.html"));
    }
    return (deliver);
}
