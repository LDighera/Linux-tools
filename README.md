# **Linux-tools**

A curated collection of practical command-line utilities, scripts, and configuration aids for Linux system administration, troubleshooting, and automation.
These tools emphasize clarity, portability, and minimal dependencies—ideal for technicians, power users, and developers who prefer transparent, script-based solutions.

---

## **Overview**

This repository includes tools for:

* System monitoring and performance tuning
* Network diagnostics and configuration
* Storage and file management
* Process and memory analysis
* Shell scripting and automation examples
* Raspberry Pi and embedded Linux utilities

Each tool is self-contained, documented, and tested primarily on **Debian Bookworm** and **Raspberry Pi OS**.

---

## **Usage**

Clone the repository:

```bash
git clone https://github.com/LDighera/Linux-tools.git
cd Linux-tools
```

Make a script executable and run it:

```bash
chmod +x example-tool.sh
./example-tool.sh
```

For system-wide installation:

```bash
sudo cp tool-name.sh /usr/local/bin/
```

---

## **Structure**

```
Linux-tools/
├── system/        # System information, uptime, swap, CPU, memory tools
├── network/       # Ping sweeps, bandwidth tests, connection monitors
├── storage/       # Disk usage, mount analysis, backup scripts
├── security/      # Permissions, audit, user access scripts
└── misc/          # Miscellaneous helpers and experiments
```

---

## **Compatibility**

* Tested on: Debian 12 (Bookworm), Raspberry Pi OS 64-bit
* Architecture: x86_64, ARM64
* Shell: bash ≥ 5.1; ksh

---

## **Contributions**

Pull requests are welcome.
If you add a new script, please:

1. Include a brief header (purpose, author, date, usage).
2. Use descriptive variable names and comments.
3. Follow the existing directory organization.

---

## **License**

This project is released under the **MIT License**.
See `LICENSE` for details.

---

Would you like me to include a short “About the Author” section referencing your background as an IBEW Journeyman Inside Wireman and Linux systems builder? It would personalize the repository.
