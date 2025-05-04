# 06-Hidden Files Scraping

## 🧠 What is Hidden Files Scraping?

**Hidden Files Scraping** is a vulnerability where an attacker can discover and access files or directories that are not intended to be publicly accessible by systematically crawling and analyzing a web application. This often involves identifying patterns in URLs or relying on predictable file names (like `README`, `.git`, etc.) to uncover sensitive information.

---

## 🔍 Scenario: Finding a Flag in Hidden README Files

In this scenario, the target web application has a hidden directory located at `http://192.168.1.32/.hidden/`. The objective is to find a flag that might be present within one of the many `README` files located within this hidden directory or its subdirectories. To achieve this, a scraping script (`run.py`) is used to recursively explore the directory structure and examine the content of any found `README` files.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:

1. 🕵️‍♂️ **Identify Hidden Directories:** The attacker first discovers the existence of the `.hidden/` directory, potentially through information disclosure, directory listing vulnerabilities (if enabled), or educated guessing based on common hidden directory names.
2. 🛠️ **Develop a Scraping Script:** A script like `run.py` is created to automate the process of exploring the web application:
3. ⚙️ **Recursive Crawling:** The scrapping_recursive function takes a URL as input, retrieves the HTML content, and parses it using `BeautifulSoup`. It then looks for all <a> tags (links).
4. 🔍 **Targeting README Files:** For each link found, the script checks if the link target (final_link) is exactly `"README"`. If it is, the script accesses the content of that `README` file.
5. 🗑️ **Filtering Out Noise:** The script includes logic to filter out `README` files containing specific keywords ("Demande", "Toujours", "Tu", "Non"), likely to reduce the number of irrelevant files and focus on those potentially containing the flag.
6. 💾 **Saving Results:** The content of the `README` files that pass the filtering criteria is written to a file named results.txt.
7. 🚀 **Execution and Analysis:** The script is executed, starting from the initial hidden directory URL. It recursively explores subdirectories, looking for `README` files and saving their content. After the script finishes (which might take a "long time" as mentioned), the attacker analyzes the results.txt file to find the flag.

---

## 🛡️ How to Defend Against Hidden Files Scraping
### ✅ Secure Development Principles
- **Principle of Least Privilege:** Only grant the necessary access to files and directories.
- **Default Deny:** Assume all files and directories are private unless explicitly made public.
- **Avoid relying on obscurity for security:** Hiding files or directories is not a robust security measure.

### 🛠️ Technical Controls
- **Implement proper access controls and permissions:** Ensure that hidden files and directories are not accessible through web requests. Configure the web server to restrict access to these resources.
- **Do not place sensitive information** in `publicly` accessible directories, even if `"hidden"`: If a file contains sensitive data, it should be stored in a location that is `not served by the web server`.
- **Use strong authentication and authorization mechanisms:** Restrict access to sensitive areas of the application based on user roles and permissions.
- **Regularly audit your web server configuration:** Ensure that there are no `misconfigurations` that could expose hidden files or directories.
- **Avoid predictable file names** for sensitive information: While not a primary security measure, using less obvious names can make scraping slightly more difficult.
- **Implement rate limiting and monitor** for unusual crawling activity: Detect and potentially `block automated scripts` that are aggressively scanning the website.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | Hidden Files Scraping                              |
| 📍 Example       | Using a script to find a flag in hidden README files |
| ⚠️ Risk          | Exposure of sensitive information, configuration details, or API keys |
| 🛡️ Fix           | Proper access controls, not relying on obscurity, regular audits |

---

## ⚙️ Tools and Resources
- **Python requests and BeautifulSoup:** Libraries used in the example script for making HTTP requests and parsing HTML.
wget and curl: Command-line tools that can be used for web scraping.
- **Web Application Scanners** (e.g., OWASP ZAP, Burp Suite): Can be configured to perform targeted crawling and identify potential hidden files and directories.
- **Directory Bruteforcing Tools** (e.g., DirBuster, GoBuster): Used to discover hidden files and directories by trying common and custom names.

> **Remember:** Security through obscurity is not security—never store sensitive data in publicly accessible or easily guessable locations, and always enforce proper access controls and server configurations to prevent unauthorized scraping or directory traversal.
