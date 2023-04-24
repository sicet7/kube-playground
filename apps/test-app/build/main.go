package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", handleRequest)
	log.Println("Starting web server on port 8080")
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}

func handleRequest(w http.ResponseWriter, r *http.Request) {
	headers := make(map[string]string)

	for name, values := range r.Header {
		headers[name] = values[0]
	}

	w.Header().Set("Content-Type", "application/json")
	jsonResponse, err := json.Marshal(headers)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	_, err = w.Write(jsonResponse)
	if err != nil {
		log.Printf("Error writing response: %v", err)
	}
}