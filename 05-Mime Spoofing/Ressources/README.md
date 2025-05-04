# 05-HTTP Header Manipulation (MIME/Referer/User-Agent Spoofing)

## 🧠 What is HTTP Header Manipulation (Spoofing)?

**HTTP Header Manipulation**, often referred to as spoofing in this context, involves altering the values of HTTP headers sent in a request to a web server. Attackers can modify headers like `Referer`, `User-Agent`, `Content-Type` (MIME type), and others to bypass security checks, gain unauthorized access, or trigger unintended server-side behavior.

---

## 🔍 Scenario: Bypassing Referer and User-Agent Checks
In this scenario, accessing a specific page [http://x.x.x.x](http://10.12.250.253/?page=e43ad1fdc54babe674da7c7b8f0127bde61de3fbe01def7d00f151c2fcca6d1c) requires the request to appear as if it originated from `https://www.nsa.gov/` and is using a specific browser identified as `"ft_bornToSec"`. These checks are likely implemented by examining the `Referer` and `User-Agent` HTTP request headers.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:
1. 🕵️‍♂️ **Information Gathering:** By examining the comments on the initial page, we discover the requirements to proceed: the `Referer` header must be set to `https://www.nsa.gov/` and the `User-Agent` header must be set to `"ft_bornToSec"`.
2. 🛠️ **Crafting the Malicious Request:** We use a tool like `curl` to construct an `HTTP request` with the necessary forged headers:
```bash
curl -e [https://www.nsa.gov/](https://www.nsa.gov/) -A "ft_bornToSec" "http://10.12.250.232/?page=e43ad1fdc54babe674da7c7b8f0127bde61de3fbe01def7d00f151c2fcca6d1c" | grep flag
```
- **-e https://www.nsa.gov/:** Sets the Referer header to `https://www.nsa.gov/`, making the server believe the `request` is coming from that page.
- **-A "ft_bornToSec":** Sets the User-Agent header to "ft_bornToSec", making the server believe we are using the specified custom browser.
The `target URL` is the page we are trying to access.
- **| grep flag:** Filters the server's response to look for the string `"flag"`, indicating successful access.
3. 🚀 **Bypassing the Checks:** By including these manipulated headers in our `request`, we successfully bypass the server-side checks that were intended to restrict access based on the origin and the browser being used.
4. 🏆 **Retrieving the Flag:** The server, believing the `request` is legitimate, processes it and returns the page content, which in this case contains the flag.

## 🛡️ How to Defend Against HTTP Header Spoofing
### ✅ Secure Development Principles
- **Never rely solely on client-provided HTTP headers** for critical security decisions: Headers can be easily manipulated by the client.
- Implement **robust server-side checks and authentication** mechanisms.
- **Validate all input**, regardless of its source (including `HTTP headers`).

### 🛠️ Technical Controls
- **Server-Side Session Management:** Use secure session `IDs` managed server-side instead of relying on client-side information like User-Agent for authentication.
- **Strong Authentication and Authorization:** Implement proper `authentication` (verifying the user's identity) and `authorization` (verifying what the user is allowed to do) mechanisms that do not depend on easily spoofed headers.
- **Token-Based Authentication (e.g., JWT):** Use secure `tokens` issued after successful authentication to track user sessions, rather than relying on headers.
- **Content Security Policy (CSP):** While not directly preventing header spoofing, CSP can help mitigate the impact of `certain attacks (like XSS`) that might be facilitated by header manipulation.
- **Avoid Logic Based on User-Agent:** User-Agent strings are easily changed and should not be used for `security` decisions or to gate access to sensitive features. Use `feature detection` instead for browser-specific functionality.
- **Be Cautious with Referer Header:** While the Referer header can sometimes be useful for logging or analytics, it should not be the sole basis for access control, as it can be `easily spoofed or omitted`by clients.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | HTTP Header Manipulation (Referer and User-Agent Spoofing)                              |
| 📍 Example       | Forging Referer and User-Agent headers to access a restricted page |
| ⚠️ Risk          | Bypassing access controls, unauthorized access to sensitive content |
| 🛡️ Fix           | Robust server-side checks, secure session management, strong authentication |

---

## ⚙️ Tools and Resources
curl: A command-line tool for making HTTP requests with the ability to set custom headers.
Web Browser Developer Tools (F12): Allow inspection and modification of HTTP request headers.
Burp Suite or OWASP ZAP: Proxy tools that enable interception and modification of all HTTP traffic, including headers.
Online Header Checkers: Can be used to inspect the headers being sent by your browser.

> **Remember:** Any data sent by the client—including HTTP headers—can be manipulated; never base security decisions on them without server-side verification and strong authentication mechanisms.
