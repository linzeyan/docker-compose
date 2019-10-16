#!/bin/bash

/opt/cert-server/ssl-cert-server -listen=0.0.0.0:18999 -email=certserver@gmail.com -pattern=".*"&
/usr/sbin/nginx -g "daemon off;"
