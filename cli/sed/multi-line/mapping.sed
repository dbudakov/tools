/^p[0-9]+/ {
    1h;
    2,$H;
    $d;
}

/^e[0-9]+/ {
    N;
    N;
    s/\n/,/g;
    s/.*/(&)/;
    P;
    x;
    P;
    s/^[^\n]*\n//;
    x;
    D;
}