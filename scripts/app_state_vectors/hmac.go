package main

import (
	"crypto/hmac"
	"crypto/sha256"
)

func concatHMAC(key, data []byte) []byte {
	m := hmac.New(sha256.New, key)
	m.Write(data)
	return m.Sum(nil)
}
