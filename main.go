package main

import (
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	_, err := w.Write([]byte("Hello World"))
	if err != nil {
		return
	}
}
func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil) //сервер работает на порту 8080
}
