#!/usr/bin/env bash

SRVPORT=4499
RSPFILE=response
TLS_PORT=9443
CERT_PATH="/etc/ssl/certs/wisecow.crt"
KEY_PATH="/etc/ssl/private/wisecow.key"

# Cleanup old response file
rm -f $RSPFILE
mkfifo $RSPFILE

get_api() {
    read line
    echo $line
}

handleRequest() {
    get_api
    mod=$(/usr/games/fortune)

    cat <<EOF > $RSPFILE
HTTP/1.1 200 OK
Content-Type: text/html

<pre>`/usr/games/cowsay $mod`</pre>
EOF
}

prerequisites() {
    command -v /usr/games/cowsay >/dev/null 2>&1 && echo "cowsay found" || echo "cowsay not found"
    command -v /usr/games/fortune >/dev/null 2>&1 && echo "fortune found" || echo "fortune not found"
    command -v nc >/dev/null 2>&1 && echo "nc found" || echo "nc not found"
    command -v socat >/dev/null 2>&1 && echo "socat found" || echo "socat not found"
    if ! command -v /usr/games/cowsay >/dev/null 2>&1 || ! command -v /usr/games/fortune >/dev/null 2>&1 || ! command -v nc >/dev/null 2>&1 || ! command -v socat >/dev/null 2>&1; then
        echo "Install prerequisites."
        exit 1
    fi
}

start_server() {
    # Start the application server in the background
    while [ 1 ]; do
        cat $RSPFILE | nc -lN $SRVPORT | handleRequest
        sleep 0.01
    done
}

main() {
    prerequisites
    echo "Wisdom served on port=$SRVPORT and TLS on port=$TLS_PORT..."

    # Start the application server
    start_server &

    # Use socat to wrap the application server with TLS
    socat openssl-listen:$TLS_PORT,cert=$CERT_PATH,key=$KEY_PATH,reuseaddr,fork tcp:localhost:$SRVPORT
}

main
