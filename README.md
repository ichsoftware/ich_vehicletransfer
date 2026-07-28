<h1 align="center">🚗 ich_vehicletransfer</h1>

<p align="center">
  A lightweight and customizable vehicle transfer system for FiveM Qbox servers — designed for realism, security, and ease of use.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Lua-100%25-blueviolet?logo=lua&logoColor=white" alt="Lua" />
  <img src="https://img.shields.io/github/license/ichsoftware/ich_weathermenu" alt="License" />
</p>

---

## 🧩 About The Project

A secure vehicle transfer script for FiveM Qbox servers. It allows players to seamlessly transfer vehicle ownership via a simple command (/aracdevret [ID]), provided both players are inside the exact same vehicle and the sender is the official owner. Built with ox_lib and oxmysql for optimal performance and safety.


---

## 🛠️ Built With

| Technology | Description |
|------------|-------------|
| ![Lua](https://img.shields.io/badge/-Lua-2C2D72?logo=lua&logoColor=white) | Core scripting language used for menu and weather logic |

---

## ⚙️ Getting Started

Getting started with **ich_vehicletransfer** is simple and fast. No need for build tools or complex setups.

## 📁 Project Structure

ich_vehicletransfer/<br>
├── fxmanifest.lua # FiveM resource manifest<br>
├── client.lua # Main code text<br>
├── server.lua # Core logging logic<br>
└── README.md # Project documentation<br>

### 📦 Installation

1. Clone or download the repository.
2. Place the `ich_vehicletransfer` folder in your `resources` directory.
3. Add the following line to your `server.cfg`:

```cfg
ensure ich_vehicletransfer
