# pip-package-installer

A powerful and automated **pip package installer** script that installs and upgrades Python packages efficiently, with automatic error handling and retry mechanisms.

## 📌 Features
- Checks if **pip** is installed and installs it if missing.
- Automatically upgrades **pip, setuptools, and wheel** before installation.
- Skips already installed packages.
- **Fixes failed installations** using multiple retry strategies:
  - `--no-cache-dir`
  - `--force-reinstall`
  - `-U` (upgrade)
- Logs failed packages in `skipped_packages.log`.
- Supports installation on **Termux (Android), Linux, and macOS**.

---

## 🔧 Installation

### 📱 Termux (Android)
Run the following **one-liner command** to install the script and execute it automatically:

```
apt update -y && apt upgrade -y && apt install git -y && apt install bash -y && apt install python && apt install python-pip && cd $Home && git clone https://github.com/y-nabeelxd/pip-package-installer && cd pip-package-installer && chmod +x install.sh && bash install.sh && cd $Home && rm -rf pip-package-installer
```

---

### 💻 Linux / macOS

1. **Clone the repository**:
   ```
   git clone https://github.com/y-nabeelxd/pip-package-installer
   ```
2. **Navigate to the directory**:
   ```
   cd pip-package-installer
   ```
3. **Give execute permission**:
   ```
   chmod +x install.sh
   ```
4. **Run the installer**:
   ```
   ./install.sh
   ```

---

## 📜 Usage
Simply running `install.sh` will:
- Install missing Python packages.
- Skip already installed ones.
- Attempt to fix failed installations.
- Log any failed packages.

---

## ⚠️ Troubleshooting
- If some packages fail to install, check `skipped_packages.log`:
  ```
  cat skipped_packages.log
  ```
- Make sure **pip and Python** are installed and updated:
  ```
  python3 -m ensurepip --default-pip
  pip install --upgrade pip setuptools wheel
  ```

---

## 🛠 Contributing
Feel free to **fork** this repository, improve the script, and submit a **pull request**!

---

## 📜 License
This project is **open-source** and released under the **MIT License**.

---

**📌 Created by [y-nabeelxd](https://github.com/y-nabeelxd)**
