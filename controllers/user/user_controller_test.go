package user_controller

import (
	"testing"
)

func TestLoginUser(t *testing.T) {
	type args struct {
		Body string
	}
	tests := []struct {
		name string
		args args
	}{
		// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// LoginUser(tt.args.Body)
		})
	}
}

func TestLoginUserUDP(t *testing.T) {
	type args struct {
		Body string
	}
	tests := []struct {
		name string
		args args
	}{
		// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			LoginUserUDP(tt.args.Body)
		})
	}
}
