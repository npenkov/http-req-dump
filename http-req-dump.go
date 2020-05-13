package main

import (
	"fmt"
	"net/http"
	"net/http/httputil"
)

func dumpRequest(w http.ResponseWriter, req *http.Request) {
	reqData, err := httputil.DumpRequest(req, true)
	if err != nil {
		fmt.Fprintf(w, "%s\n", err)
		return
	}
	fmt.Fprintf(w, "%s", string(reqData))
}

func main() {
	http.HandleFunc("/", dumpRequest)
	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Printf("error running http server at port 8080 : %v\n", err)
	}
}
