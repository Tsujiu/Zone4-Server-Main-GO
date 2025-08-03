# Use an official lightweight Go image for the build stage
FROM golang:1.23.2-alpine AS builder
# ใช้ base image สำหรับ Go
FROM golang:1.20-alpine

# ตั้ง working directory ใน container
WORKDIR /app

# คัดลอกไฟล์ทั้งหมดจากโฟลเดอร์โปรเจกต์ของคุณลงใน container
COPY . .

EXPOSE 9000
EXPOSE 9000/udp
EXPOSE 9001
EXPOSE 9001/udp

# ใช้ go run เพื่อรันโปรแกรมโดยตรงจาก source code
CMD ["sh", "-c", "go run cmd/server/main.go"]
