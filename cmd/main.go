package main

import (
	"log"

	kingpin "github.com/alecthomas/kingpin/v2"
	"github.com/lafeingcrokodil/cartographers/server"
)

// We set this value as part of the build process using `-ldflags "-X main.version=$VERSION"`.
var version = "unknown" // nolint:gochecknoglobals

func main() {
	var port int

	kingpin.Version(version)
	kingpin.Flag("port", "Port to listen on.").
		Default("8080").Envar("PORT").IntVar(&port)
	kingpin.Parse()

	s := server.New(port)
	if err := s.Start(); err != nil {
		log.Fatal(err)
	}
}
