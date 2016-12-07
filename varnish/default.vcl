vcl 4.0;

backend default {
    .host = "upstream";
    .port = "80";
}
