#!/bin/bash
cd attendance
cd attendance-api/
poetry shell
gunicorn app:app --log-config log.conf -b 0.0.0.0:8080
