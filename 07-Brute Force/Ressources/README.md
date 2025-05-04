# 07-Brute Force

## 🧠 What is Brute Force?
**Brute Force** is a straightforward attack method used to guess passwords, keys, or find hidden content by systematically trying every possible combination until the correct one is found. The effectiveness of a brute force attack depends heavily on the complexity of the target and the number of attempts an attacker can make.

---

## 🔍 Scenario: Guessing Admin Password on a Login Page
In this scenario, the goal is to guess the password for the "admin" user on the login page located at `http://10.12.250.232/?page=signin`. The attacker utilizes a list of commonly used passwords and a script to automate the process of submitting login attempts.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:
1. 🎯 **Identify the Target:** The login page URL (`http://10.12.250.232/?page=signin`) and the target username `("admin")` are identified.
2. 📚 **Password List Acquisition:** A list of commonly used passwords, such as the top 25 most frequent passwords, is obtained from publicly available sources. The provided script includes such a list:
```bash
password=(123456 password 12345678 qwerty abc123 123456789 111111 1234567 iloveyou adobe123 123123 Admin 1234567890 letmein photoshop 1234 monkey shadow sunshine 12345 password1 princess azerty trustno1 000000)
```
3. 🤖 **Script Automation:** A script (originally a Bash script, adapted below for `Ubuntu 22.04` with enhanced messages) is used to iterate through the password list and submit login requests to the target page.
4. 📤 **Submitting Login Attempts:** The script sends `HTTP POST requests` to the login page with the username set to "admin" and the password taken from the current entry in the password list.
5. 🔍 **Analyzing the Response:** After each login attempt, the script analyzes the server's response to check if the login was successful. In the original script, it uses `grep 'flag'` to look for the string `"flag"` in the response, which is assumed to be present upon successful login.

---

## 🛡️ How to Defend Against Brute Force Attacks
### ✅ Secure Development Principles
- **Limit the number of failed login attempts:** This is the most effective way to mitigate brute force attacks.
- Implement **strong password policies**: Enforce the use of complex passwords that are difficult to guess.
- Use multi-factor authentication **(MFA)**: Adds an extra layer of security beyond just a password.

### 🛠️ Technical Controls
- **Account Lockout:** Temporarily or permanently lock user accounts after a certain number of consecutive failed login attempts.
- **Rate Limiting:** Restrict the number of login attempts from a specific IP address or user within a given time frame.
- **CAPTCHA or reCAPTCHA:** Implement challenges that are easy for `humans` to solve but difficult for `bots`, preventing automated brute force attacks.
- **Implement strong password hashing algorithms** (e.g., bcrypt, Argon2): While this doesn't directly prevent brute force, it makes the stolen password hashes much harder to crack if the database is compromised.
- Two-Factor Authentication **(2FA)** or Multi-Factor Authentication **(MFA)**: Require users to provide an `additional verification factor` (e.g., a code from an authenticator app or SMS) in addition to their password.
- **Monitor for Suspicious Activity:** Log and analyze login attempts for unusual patterns, such as a high number of failed attempts from a `single IP address`.
- **Use Web Application Firewalls (WAFs):** WAFs can help detect and block `malicious requests`, including those associated with brute force attacks.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | Brute Force                              |
| 📍 Example       | ttempting to guess the admin password using a common password list |
| ⚠️ Risk          | Unauthorized access to user accounts and sensitive data |
| 🛡️ Fix           | Account lockout, rate limiting, CAPTCHA, MFA |

---

## ⚙️ Tools and Resources
- **curl:** A command-line tool for making HTTP requests.
- **grep:** A command-line utility for searching plain-text data sets for lines matching a regular expression.
- **Hydra:** A popular parallelized login cracker which supports numerous protocols.
- **Medusa:** Another fast, parallel, modular, login brute-forcer.
- **Burp Suite Intruder:** A powerful tool within Burp Suite for automating customized attacks, including brute force.
- **OWASP ZAP:** An open-source web application security scanner that includes tools for brute-force attacks as well as defenses.

> **Remember:** Brute force attacks are noisy and easily detectable — effective defense requires a layered approach that combines technical controls like rate limiting and account lockout with strong password policies and multi-factor authentication to truly protect against unauthorized access.
