# 01-Open Redirect

## 🧠 What is Open Redirect?
An **Open Redirect** vulnerability arises when a web application uses a user-supplied parameter to redirect the user to another website without proper validation. This can be exploited by attackers to lead users to malicious sites that may harvest credentials or spread malware, often disguised as legitimate links.

---

## 🔍 Scenario: Social Media Link Manipulation

In this instance, we encountered a social media link within the application's HTML structure that employed a `redirect` parameter to determine the target website:
```html
<a href="index.php?page=redirect&amp;site=facebook" class="icon fa-facebook"></a>
```
The crucial point here is that the value of the site parameter dictates the redirection destination. Without adequate server-side checks, this opens a pathway for manipulation.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:
1. 🔗 Go to the website and scroll to the **footer section**.

2. 🕵️‍♂️ Right-click on a link like "Follow us on Facebook" and **inspect** the URL:
```
href="index.php?page=redirect&site=facebook"
```
3. ✏️ Replace the `to` parameter with your own malicious site:
```
href="index.php?page=redirect&site=evil.com"
```
4. 🚨 Now, if a user clicks that link, they will be **redirected to `evil.com`** instead of Facebook.

5. 🧪 This can be used for:
   - Phishing (stealing credentials)
   - Session hijacking
   - Malware delivery
   - Social engineering attacks

---

## 🛡️ How to Defend Against Open Redirect
### ✅ Secure Development Principles
- Avoid user-controlled redirects whenever possible: The safest approach is often to avoid relying on user input to determine redirection targets.
- Validate and sanitize all user-supplied `URLs`: If redirects based on user input are necessary, strictly validate the format and content of the provided URL.
- Maintain a **whitelist** of trusted domains: If redirection to external sites is required, restrict the possible destinations to a predefined list of known and trusted domains.

### 🛠️ Technical Controls
- Use **absolute URLs** for redirects: Instead of allowing user-controlled parameters, use server-side logic to generate complete and trusted URLs for redirection.
- Employ **secure tokens or one-time-use codes:** For sensitive redirects (e.g., after authentication), use secure, time-limited `tokens` that cannot be easily manipulated.
- Implement Content Security Policy (CSP): Configure `CSP` headers to restrict the domains to which the browser is allowed to navigate.
- **Log and monitor** redirect activity: Keep track of redirection events to identify and respond to suspicious patterns.

## ✅ Summary
| Key Aspect       | Details                                           |
|------------------|---------------------------------------------------|
| 🔓 Vulnerability  | Open Redirect|
| 📍 Example        | Manipulating the site parameter in a social link|
| ⚠️ Risk           | Phishing, malware distribution, social engineering|
| 🛡️ Fix            | Whitelisting, absolute URLs, secure tokens|

---

## ⚙️ Tools and Resources
- **Burp Suite:** A comprehensive web security testing tool that can intercept and manipulate HTTP requests, including redirect parameters.
- **OWASP ZAP (Zed Attack Proxy):** A free and open-source web application security scanner that can help identify open redirect vulnerabilities.
- **URL Decoder/Encoder:** Useful for encoding and decoding URLs to understand how they are being processed and to craft malicious payloads.

> **Remember:** Open Redirects might seem less severe than vulnerabilities like IDOR, but they can be a crucial stepping stone in larger attacks, enabling attackers to convincingly lure victims to malicious destinations.