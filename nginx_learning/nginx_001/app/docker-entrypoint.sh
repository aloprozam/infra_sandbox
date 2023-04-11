#!/usr/bin/env ash
gunicorn --bind 0.0.0.0:8080 --workers=1 --log-level debug main:app