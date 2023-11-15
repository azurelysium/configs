#!/bin/bash

(socat TCP-LISTEN:80,fork,reuseaddr TCP-CONNECT:127.0.0.1:8080) &
(socat TCP-LISTEN:443,fork,reuseaddr TCP-CONNECT:127.0.0.1:4443) &

sleep infinity
