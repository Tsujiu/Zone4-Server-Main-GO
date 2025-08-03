package models

import (
	"crypto/aes"
	"crypto/cipher"
	"encoding/base64"
	"fmt"
	"maxion-zone4/config"
)

// DecryptMessage decrypts a base64-encoded ciphertext using AES-CFB
func DecryptMessage(encodedCiphertext string) (string, error) {
	// Decode the base64-encoded ciphertext
	ciphertext, err := base64.StdEncoding.DecodeString(encodedCiphertext)
	if err != nil {
		return "", fmt.Errorf("error decoding base64: %w", err)
	}

	// Initialize AES cipher
	block, err := aes.NewCipher(config.AESKey)
	if err != nil {
		return "", fmt.Errorf("error creating cipher: %w", err)
	}

	// Initialize CFB decryption stream
	stream := cipher.NewCFBDecrypter(block, config.AESIV)

	// Prepare buffer for decrypted data
	plaintext := make([]byte, len(ciphertext))

	// Perform the CFB decryption
	stream.XORKeyStream(plaintext, ciphertext)

	return string(plaintext), nil
}

// EncryptMessage encrypts a plaintext message using AES-CFB and returns a base64-encoded ciphertext
func EncryptMessage(plaintext string) (string, error) {
	block, err := aes.NewCipher(config.AESKey)
	if err != nil {
		return "", fmt.Errorf("error creating cipher: %w", err)
	}

	stream := cipher.NewCFBEncrypter(block, config.AESIV)
	ciphertext := make([]byte, len(plaintext))
	stream.XORKeyStream(ciphertext, []byte(plaintext))

	// Base64 encode the ciphertext
	return base64.StdEncoding.EncodeToString(ciphertext), nil
}
