package main

import (
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte(`
	<html>
		<head>
		<title>GOphers</title>
		</head>
		<body>
			Welcome, Gophers!
		</body>
	</html>
`))
	})
	// start web server
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal("ListenAndServer:", err)
	}
}
