package server

import (
	"fmt"
	"log"
	"net/http"
)

// Server is a Cartographers server.
type Server struct {
	addr string // TCP address to listen on
}

// New returns a new Server instance.
func New(port int) *Server {
	return &Server{
		addr: fmt.Sprintf(":%d", port),
	}
}

// Start starts the server.
func (s *Server) Start() error {
	// Serve static assets.
	fs := http.FileServer(http.Dir("./public"))
	http.Handle("/", fs)

	// Start listening for incoming requests.
	log.Printf("INFO: Starting server on %s...\n", s.addr)
	return http.ListenAndServe(s.addr, nil)
}
