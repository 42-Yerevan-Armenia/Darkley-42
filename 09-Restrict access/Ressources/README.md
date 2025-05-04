# 09-Restrict Access Vulnerability

## 🧠 What is Restrict Access Vulnerability?
A **Restrict Access Vulnerability** occurs when mechanisms intended to limit access to certain parts of a web application or its resources are either misconfigured, bypassed, or provide unintended information to attackers about sensitive areas. This can lead to the exposure of confidential data or administrative interfaces.

---

## 🔍 Scenario: Uncovering Admin Credentials via `robots.txt` and `.htpasswd`
In this scenario, we discovered a misconfigured `robots.txt` file that inadvertently revealed the location of sensitive files, leading to the compromise of administrative credentials.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:

1. 🔎 **Checking `robots.txt`:** The first step was to check the `robots.txt` file, a standard file used to instruct web robots (like search engine crawlers) which parts of a website should not be indexed. We accessed `http://10.12.250.232/robots.txt` and found the following directives:
```
User-agent: *
Disallow: /whatever
Disallow: /.hidden
```
This file, intended to restrict access for search engines, ironically reveals the existence of potentially sensitive directories: `/whatever` and `/.hidden`.
2. 📂 **Exploring Disallowed Directories:** We decided to investigate the `/whatever` directory, as indicated in the `robots.txt`. Upon accessing `http://10.12.250.232/whatever/`, we found a `.htpasswd` file.
3. 🔑 **Analyzing `.htpasswd`:** The `.htpasswd` file contained a line with a username and a seemingly encrypted password:
login:8621ffdbc5698829397d97767ac13db3
The format `username:hashed_password` is typical for `.htpasswd` files used by Apache web servers for basic authentication.
4. 🔓 **Cracking the Hash:** By taking the hash `8621ffdbc5698829397d97767ac13db3` and searching for it online using hash identification services or online MD5 decryption tools, we quickly determined that it was an MD5 hash. Decrypting this hash revealed the password to be `dragon`.
5. 🚪 **Accessing the Admin Interface:** Knowing the username (`login`) and the password (`dragon`), we attempted to access the administrative interface of the website, which is often located at a predictable URL like `/admin`. By navigating to `http://10.12.250.232/admin` and providing the discovered credentials, we successfully gained access, likely obtaining the flag within this administrative area.

---

## 🛡️ How to Defend Against Restrict Access Vulnerabilities
### ✅ Secure Development Principles
- **Principle of Least Exposure:** Only expose necessary files and directories to the public.
- **Secure by Default:** Assume all resources are private unless explicitly made public with proper access controls.
- **Don't rely on obscurity for security:** Hiding sensitive files without proper authentication and authorization is not a secure practice.

### 🛠️ Technical Controls
- **Proper Access Control Configuration:** Implement robust authentication and authorization mechanisms to protect administrative interfaces and sensitive data.
- **Secure Storage of Credentials:** Never store passwords in plaintext. Use strong, salted hashing algorithms. Avoid storing credentials in publicly accessible files like `.htpasswd` within the web root.
- **Restrict Web Server Access to Sensitive Files:** Configure the web server (e.g., Apache, Nginx) to prevent direct access to sensitive files like `.htpasswd`, `.git/`, configuration files, and other internal application files. This can be done through server configuration or using `.htaccess` files (for Apache).
- **Careful Use of `robots.txt`:** While `robots.txt` is useful for SEO, it should not be used as a security mechanism to hide sensitive areas. Attackers will specifically look at this file.
- **Implement HTTP Security Headers:** Use headers like `X-Robots-Tag` in server responses or `.htaccess` to control indexing and following of links by search engine bots, as suggested in the scenario's "How to avoid it?" section.
- **Regular Security Audits:** Conduct regular security assessments to identify and remediate any misconfigurations or exposed sensitive information.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | Restrict Access (Information Disclosure, Weak Credentials) |
| 📍 Example       | Finding admin credentials via `robots.txt` and `.htpasswd` |
| ⚠️ Risk          | Unauthorized access to administrative interfaces and sensitive data |
| 🛡️ Fix           | Proper access controls, secure credential storage, web server configuration |

---

## ⚙️ Tools and Resources

- **Web Browser:** Used to inspect `robots.txt` and access web pages.
- **Online MD5 Decryption Tools:** Used to attempt to reverse the MD5 hash found in `.htpasswd`.
- **Command-line tools (`curl`, `wget`):** Useful for fetching `robots.txt` and other web resources.
- **Web Server Configuration Documentation (Apache, Nginx):** Essential for understanding how to restrict access to files and directories.
- **`.htaccess` Documentation (Apache):** For configuring directory-level access controls.

> **Remember:** robots.txt is a courtesy, not a security control—anything listed there is basically a roadmap for attackers.