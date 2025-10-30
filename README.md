

# 🧩 16KB Script — Verify ELF Page Alignment for Android Builds

Google Play has introduced a **16KB page size requirement** for native binaries (`.so` files) on modern Android devices.
If your Flutter or Unity app contains native libraries that don’t meet this alignment, **your submission may be rejected**.

This repository provides **simple scripts** for **Mac/Linux (Shell)** and **Windows (PowerShell)** to help verify whether your APK is **16KB page size compliant**.

---

## 🐧 Mac & Linux (Shell Script)

### 🎯 Overview

This shell script checks whether your Flutter app’s native libraries are correctly aligned with the **16KB page size** requirement.

### 🧭 Steps to Use

1. **Create the script file**
   In your Flutter project root, create a file named `check_elf_alignment.sh` and paste the script content inside.

2. **Make the script executable**

   ```bash
   chmod +x check_elf_alignment.sh
   ```

3. **Build your release APK**

   ```bash
   flutter build apk --release
   ```

4. **Run the script with your APK path**

   ```bash
   ./check_elf_alignment.sh app/build/outputs/apk/release/app-release.apk
   ```

✅ The script analyzes each `.so` file inside your APK and reports whether it meets the **16KB page alignment requirement**.

---

## 🪟 Windows (PowerShell Script)

If you’re verifying compliance on Windows, use the provided PowerShell script.
It’s based on a Unity project example but works for **any Android APK** that contains native libraries.

### ⚙️ How to Use

1. **Build your Android APK**
2. **Unzip** the APK to any folder.
3. **Locate the native libs folder** (typically `\lib\arm64-v8a`).
4. **Run the PowerShell script** in that directory.
   It will generate a `.csv` report showing the page alignment for each `.so` file.
5. **Interpret the results:**

   * `1000` → ❌ **Not compliant**
   * `4000` → ✅ **16KB compliant**

---

### 🧩 Compatibility Tips for Unity Projects

To ensure compliance:

* Update all Unity packages and vendor SDKs.
* Set **minimum Android API level to 15** or higher.
* Build for **ARM64 architecture**.


---

🙌 Acknowledgments

Special thanks to the open-source community and contributors who shared their insights and scripts, making it easier for developers to ensure Google Play 16KB page size compliance across platforms.



---

### 💡 Summary

Both scripts are lightweight and designed to help you **quickly verify Google Play’s 16KB page size compliance** before submission.
They can be easily integrated into your **CI/CD pipeline** or used manually for quick checks.
