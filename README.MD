# Microsoft Store Installer for Windows LTSC

A batch script to **restore the Microsoft Store and its dependencies** on Windows LTSC (or other Windows editions where it’s missing).  
It installs all required AppX and MSIX packages in the correct order to avoid dependency errors.

---

## ⚙️ Tested On

- ### Windows 11 Enterprise N LTSC 24H2

## 🔧 Usage

1. **Run as Administrator**:
   - Right-click `Add-Microsoft-Store.bat` → **Run as administrator**

2. Wait for the process to complete.  
   If all goes well, Microsoft Store should now be installed.

---

## 🆘 Troubleshooting

### 1️⃣ Microsoft Store still doesn’t work
- **Step 1:** Reboot your PC.
- **Step 2:** If it still doesn’t work, open **Command Prompt as Administrator** and run:
```powershell
PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage Microsoft.WindowsStore).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}" 
```

- **Step 3:** Reboot again.

### 2️⃣ Clear Microsoft Store cache
1. Right-click Start.

2. Select Run.

3. Type: **WSReset.exe**

4. Press Enter — this will clear the Store cache.

---

### ⚠️ Notes & Warnings
- This script is intended for Windows LTSC or editions where Microsoft Store is missing.

- Running this on editions that already have the Store may reinstall or update it.

- Make sure you have Administrator privileges.

---

## 💬 Credits
- Script originally by **czvv**
