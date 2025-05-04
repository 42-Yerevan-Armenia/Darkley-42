# 08-Directory Traversal Attack

## 🧠 What is Directory Traversal?
**Directory Traversal**, also known as Path Traversal, is a web security vulnerability that allows attackers to access files and directories on a server that are outside the web root directory. This can occur when an application uses user-supplied input to construct file paths without proper sanitization, allowing attackers to use special characters like `../` to navigate up the directory structure.

---

## 🔍 Scenario: Bypassing a Trolling Path Restriction
In this scenario, we encountered a web application where the `page` parameter in the URL seemed to control which file was being included or displayed. We attempted to exploit a potential directory traversal vulnerability.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:

1. 🕵️‍♂️ **Initial Parameter Discovery:** We observed a `page` parameter in the URL:
```
http://10.12.250.232/index.php?page=survey
```
2. 🧪 **Basic Traversal Attempts:** We started testing for directory traversal by using the `../` sequence to try and move up one directory level:
```
http://10.12.250.232/index.php?page=../
```
The server responded with "Wtf?", indicating that our input was being processed but not directly blocked.
3. 🪜 **Incrementing Traversal Depth:** We continued to increase the number of `../` sequences to navigate further up the directory tree:
```
[invalid URL removed]
```
The response "Wtf?" again confirmed that `../` was being interpreted.
4. 🚧 **Encountering a Filter or Restriction:** Our next attempt with three levels up triggered a different response:
```
[invalid URL removed]

Response: "Wrong.."
```
This suggested that the application might be attempting to prevent deep traversal, but the message implied we were on the right track.
5. 🚀 **Systematic Depth Exploration:** We continued to incrementally increase the depth of our traversal attempts:
```
[invalid URL removed]
[invalid URL removed]

Responses: "Nope.." "Almost."
```
These responses acted as hints, indicating we were getting closer to the correct number of `../` sequences needed to escape the intended directory.
6. 🎯 **Pinpointing the Escape Route:** We persisted with our attempts:
```
[invalid URL removed]

Response: "Still nope.."

[invalid URL removed]

Response: "Nope.."

[invalid URL removed]

Response: "You can DO it!!! :]"
```
This encouraging message signaled that we had successfully navigated out of the restricted directory.
7. 🔥 **Accessing a Sensitive File:** Knowing the correct number of `../` sequences, we then appended the path to a sensitive system file, `/etc/passwd`, which typically contains user account information on Unix-like systems:
```
[invalid URL removed]

Response: "Congratulaton!! The flag is : ..."
```
This confirmed our successful directory traversal and access to a restricted file.

---

## 🛡️ How to Defend Against Directory Traversal Attacks
### ✅ Secure Development Principles
- **Avoid using user-supplied input directly in file paths:** This is the primary cause of directory traversal vulnerabilities.
- **Principle of Least Privilege:** The application should only have access to the files and directories it absolutely needs.
- **Default Deny:** Restrict access to all files and directories by default, and explicitly allow access to only those that are necessary.

### 🛠️ Technical Controls
- **Input Sanitization:** Strictly validate and sanitize all user-provided input that is used to construct file paths. Filter out or escape potentially malicious characters like `../`. However, relying solely on blacklisting is often insufficient.
- **Path Normalization:** Use functions provided by the operating system or framework to normalize file paths, which can help resolve relative paths and prevent traversal.
- **Chroot Jail or Sandboxing:** Confine the application's file system access to a specific directory (chroot jail) or a sandboxed environment.
- **Whitelist Allowed Files or Directories:** Instead of trying to block malicious paths, explicitly define a list of allowed files or directories that the application can access. Use an identifier or index provided by the user to look up the actual file path on the server.
- **Avoid Exposing Internal File Paths in URLs:** Design the application in a way that internal file paths are not directly exposed to the user. Use abstract identifiers instead.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | Directory Traversal (Path Traversal) |
| 📍 Example       | Using `../` sequences to access `/etc/passwd` |
| ⚠️ Risk          | Unauthorized access to sensitive files and directories, potential code execution |
| 🛡️ Fix           | Avoiding direct user input in paths, whitelisting, path normalization |

---

## 🛠️ Tools and Resources

- **Web Browser:** Used for manual testing of URL manipulation.
- **Burp Suite or OWASP ZAP:** Proxy tools that allow interception and modification of HTTP requests, making it easier to test various traversal sequences.
- **Path Normalization Libraries:** Functions available in various programming languages and frameworks to normalize file paths.
- **Operating System Documentation:** Understanding file system permissions and path structures is crucial for both exploitation and defense.

> **Remember:** Directory traversal vulnerabilities often arise from assuming user input is safe — always validate, sanitize, and normalize file paths, and implement strict access controls to ensure your application only serves the intended content and nothing more.