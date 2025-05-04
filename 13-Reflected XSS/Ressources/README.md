# 13-MIME Type Spoofing (File Upload Bypass)

## 🧠 What is MIME Type Spoofing?
**MIME Type Spoofing** is a technique used to bypass file upload restrictions on a web server by manipulating the `Content-Type` header of the HTTP request. The `Content-Type` header (also known as the MIME type) indicates the format of the data being transmitted. By sending a misleading MIME type, an attacker can trick the server into believing that a malicious file (e.g., a shell script) is a safe file type (e.g., an image), potentially leading to arbitrary code execution or other security breaches.

---

## 🔍 Scenario: Uploading a Malicious Script as an Image
In this scenario, the image upload functionality of the web application is vulnerable to MIME type spoofing. The server likely checks the `Content-Type` header provided by the client to determine if the uploaded file is a valid image. By sending a malicious script with a forged `Content-Type` header of `image/jpeg`, we can attempt to bypass this client-side or insufficient server-side validation.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:
1. ✍️ **Creating the Malicious File:** The attacker first creates the malicious file they want to upload. In this case, it's a shell script named `malicious_script.sh` (created using `touch /tmp/malicious_script.sh`). The content of this script would contain the attacker's desired commands to be executed on the server.
2. 🛠️ **Crafting the Spoofed HTTP Request:** The attacker uses a tool like `curl` to construct an `HTTP POST request` to the file upload endpoint (`$1/index.php?page=upload`). The key part of this request is the `-F` (form) option, which allows specifying file uploads and their associated metadata:
3. 📤 **Submitting the Spoofed Request:** The curl command sends the crafted `HTTP request` to the server.
4. 👀 **Server-Side Processing (Vulnerable):** If the server relies solely on the Content-Type header provided by the client to validate the file type, it will believe that /tmp/malicious_script.sh is a JPEG image.
5. 💥 **Potential Code Execution:** If the server subsequently processes the `"uploaded image"` in a way that could lead to code execution (e.g., by saving it in a web-accessible directory and then attempting to process it, or if the application has other vulnerabilities), the `attacker's shell scrip`t could be executed, allowing for arbitrary command execution on the server. 

In this scenario, the presence of the `"flag"` in the output suggests the exploit was successful in some way.

---

## 🛡️ How to Defend Against MIME Type Spoofing
### ✅ Secure Development Principles
- **Never trust client-provided information about file types:** The `Content-Type header` can be easily manipulated.
- Verify file types on the server-side using reliable methods.

### 🛠️ Technical Controls
- **Server-Side File Type Validation** (Magic Bytes Analysis): Instead of relying on the Content-Type header, analyze the actual content of the uploaded file on the server-side. This can be done by examining the "magic bytes" (the first few bytes of a file that identify its format). Libraries exist in various programming languages to perform this type of analysis.
- **Whitelist Allowed File Extensions:** Define a strict list of allowed file extensions and verify that the uploaded file's extension matches this list after proper server-side content inspection.
- **Rename Uploaded Files:** Rename uploaded files to prevent predictable file names and potential execution vulnerabilities if the filename is directly used in URLs.
- **Store Uploaded Files in Non-Executable Directories:** Store uploaded files in directories that are configured to prevent the execution of scripts (e.g., a dedicated storage directory with restricted permissions).
- **Implement Content Security Policy** (CSP): CSP can help mitigate the impact of accidentally executed scripts by restricting the sources from which executable code can be loaded.
- **Limit File Sizes:** Implement reasonable file size limits to prevent denial-of-service attacks and the upload of excessively large malicious files.
- **Regular Security Audits:** Conduct regular security assessments to identify and address file upload vulnerabilities.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | MIME Type Spoofing (File Upload Bypass) |
| 📍 Example       | Uploading a shell script as a JPEG image using curl |
| ⚠️ Risk          | Arbitrary code execution, server compromise, data breaches |
| 🛡️ Fix           | Server-side file type validation (magic bytes), whitelisting extensions |

---

## ⚙️ Tools and Resources
- **curl:** A command-line tool for making HTTP requests with the ability to set custom headers and upload files.
- **File Signature Databases** (e.g., File Signatures Database): Resources that list the magic bytes for various file formats.
- **Server-Side Programming** Language File Handling Libraries: Libraries that provide functions for analyzing file content and type (e.g., Python's filetype library).
- **Web Application Security Testing Tools** (e.g., Burp Suite, OWASP ZAP): Used to intercept and modify file upload requests to test for MIME type spoofing vulnerabilities.

> **Remember:** Never rely on user-supplied MIME types or file extensions — always inspect the actual file content on the server, and store uploaded files in non-executable locations to eliminate the risk of server-side code execution.
