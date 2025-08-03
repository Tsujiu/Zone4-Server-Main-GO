# Zone4-Server-Main-GO

Main Game Server for Zone4 (written in Go, disguised as MU Online server)

This is an open-source implementation of the **Zone4** main server (using Go), intentionally **disguised as a MU Online server** for safety and privacy reasons.

> **⚠️ Not 100% complete yet! Please help us finish this project!**

---

## About

- This server is part of a fan project to **revive the classic Zone4 game** for the community.
- The focus is **not** on making money, but on preserving and bringing back this unique game experience.
- **I have hosting!** If you want to help develop or test, please get in touch via GitHub.
- Any help, code, testing, or ideas are welcome — let’s build this together!

---

## ⚠️ Important: Requires the Channel Manager

To run the Zone4 Main Server, you **must also run the Channel Manager**:  
- [Zone4 Channel Manager](https://github.com/Tsujiu/Zone4-Change-Channels)  
- The Channel Manager controls channel processes, status, and is essential for server operation.

---

## Features

- Core game logic and networking for Zone4 (using Go)
- Works with the [Zone4 LandVerse Client](https://github.com/Tsujiu/Zone4-LandVerse-Client-and-PDB-and-Debug)
- Requires [Zone4 Channel Manager](https://github.com/Tsujiu/Zone4-Change-Channels) to operate
- Includes configuration files, example startup scripts, and Docker support
- Uses Git LFS for large files
- **Not 100% finished** — some features and systems are still missing or need improvement

---

## Getting Started

**Requirements:**
- Go 1.19 or newer
- Docker (optional, for using docker-compose)
- Redis/MariaDB (if using persistence, see `docker-compose.yml`)
- **Zone4 Channel Manager** (see above)

**To run locally:**
```bash
go run cmd/server/main.go


Support & Contribution
If you want to help, open a pull request, create an issue, or get in touch via GitHub!

Let’s finish this server and revive Zone4 together!

License
MIT

Note: This project is not affiliated with the official publishers of Zone4.
It’s a non-profit initiative by fans, for fans.
