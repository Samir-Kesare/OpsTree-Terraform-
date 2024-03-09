#!/bin/bash
cd employee-api/
make build
go test $(go list ./... | grep -v docs | grep -v model | grep -v main.go) -coverprofile cover.out
go tool cover -html=cover.out
make run-migrations
./employee-api
