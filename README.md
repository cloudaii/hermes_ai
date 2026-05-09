# Hermes 

# 🧠 Hermes Agent

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Open Source](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)](https://github.com/cloudaii/hermes_ai)

**Hermes Agent** is an open-source, self-improving AI agent framework originally developed by Nous Research. 

Unlike standard chatbots that clear their context and "forget" everything once a session ends, Hermes is designed for persistence. It lives natively on your server, retaining long-term memory, adapting to your workflows, and continuously evolving over time through autonomous learning.

---

## ✨ Key Features

* **Persistent Memory:** Retains context and conversational history across multiple sessions and server restarts.
* **Self-Improving Architecture:** Analyzes past interactions to optimize future responses and tool usage.
* **Server-Native:** Designed to run continuously in the background on your local machine or remote server.
* **Open-Source:** Fully transparent framework, allowing for deep customization and community contributions.

---

## 🚀 Installation

You can install the Hermes Agent using our automated script or by setting it up manually. 

> **Note:** Ensure you have a Linux/macOS environment or WSL (Windows Subsystem for Linux) configured before installing.

### Option 1: Quick Install (Recommended)
Use this single-line command to download and execute the installation script automatically:

```
curl -fsSL [https://raw.githubusercontent.com/cloudaii/hermes_ai/main/hermes_install.sh](https://raw.githubusercontent.com/cloudaii/hermes_ai/main/hermes_install.sh) | bash
```
**Mannual instalation**


```
# Clone rep
git clone https://github.com/cloudaii/hermes_ai.git
cd hermes_ai

# Make the script executable
chmod +x hermes_install.sh
# Run the installer
./hermes_install.sh
```

**start agent**

```
hermes setup
```
