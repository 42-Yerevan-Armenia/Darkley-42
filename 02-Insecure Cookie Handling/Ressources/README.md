# 02-Insecure Cookie Handling

## 🧠 What is Insecure Cookie Handling?
**Insecure Cookie Handling** occurs when a web application stores sensitive information, such as authentication tokens or user preferences, in cookies without adequate security measures. This can allow attackers to manipulate or steal these cookies to gain unauthorized access or perform malicious actions.

---

## 🔍 Scenario: Exploiting a Weakly Protected Admin Cookie
In this scenario, we discovered a cookie named `I_am_admin` with the following value:
```
I_am_admin=68934a3e9455fa72420237eb05902327
```
Our initial analysis revealed that this cookie likely controls administrative privileges within the application.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:
1. 🕵️‍♂️ **Cookie Extraction and Identification:** Using browser developer tools (press `F12`, navigate to the **Application** or **Storage** tab, and then **Cookies**) or a cookie management extension, we extracted the value of the `I_am_admin` cookie. Recognizing the hexadecimal string format and its length, we hypothesized it might be a cryptographic hash, specifically an MD5 hash.
2. 🔓 **Hash Decryption Attempt:** We employed an online MD5 decryption tool, such as CrackStation, and submitted the extracted hash (`68934a3e9455fa72420237eb05902327`).
3. 🔑 **Revealing the Logic:** The decryption yielded the plaintext value `"false"`. This strongly suggested that the application uses the `I_am_admin` cookie to determine if the current user has administrative rights by comparing its hashed value against the hash of `"true"` or `"false"`.
4. 🔧 **Crafting the Malicious Cookie:** Knowing that `"false"` corresponds to a non-admin state, we then calculated the MD5 hash of `"true"`:
```
md5("true") = b326b5062b2f0e69046810717534cb09
```
5. ✏️ **Cookie Manipulation:** Using browser developer tools or a cookie editing extension like EditThisCookie, we modified the value of the `I_am_admin` cookie in our browser, replacing the original hash with the newly generated hash of `"true"` (`b326b5062b2f0e69046810717534cb09`).
6. 🚀 **Gaining Unauthorized Access:** Upon refreshing the web page, the application now reads the modified cookie. Because the hashed value corresponds to `"true"`, we successfully bypassed the intended access controls and gained unauthorized administrative privileges.

---

## 🛡️ How to Defend Against Insecure Cookie Handling
### ✅ Secure Development Principles
- **Avoid storing sensitive data directly in cookies:** Cookies are inherently client-side and can be inspected and manipulated.
- **Treat cookies as untrusted input:** Always validate and sanitize cookie values on the server-side.
- **Implement proper session management:** Use secure session IDs stored in cookies and manage session data server-side.
- **Employ strong, salted hashing algorithms for sensitive data (though ideally, avoid storing it in cookies altogether).**

### 🛠️ Technical Controls

- **Use the `HttpOnly` flag:** This attribute prevents client-side scripts (like JavaScript) from accessing the cookie, mitigating the risk of cross-site scripting (XSS) attacks stealing the cookie.
- **Use the `Secure` flag:** This attribute ensures that the cookie is only transmitted over HTTPS, protecting it from eavesdropping during transmission.
- **Implement strong encryption for any sensitive data that must be stored in cookies.**
- **Consider using signed cookies:** Cryptographically sign cookies to detect tampering on the client-side. However, this does not prevent a determined attacker from replaying a valid cookie.
- **Store authentication state server-side:** Rely on server-side session management rather than encoding authentication information directly in cookies.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | Insecure Cookie Handling                              |
| 📍 Example       | Manipulating a weakly hashed admin privilege cookie |
| ⚠️ Risk          | Unauthorized access, privilege escalation, data leaks |
| 🛡️ Fix           | `HttpOnly` and `Secure` flags, server-side sessions, strong encryption |

---

## ⚙️ Tools and Resources

- **Burp Suite:** A powerful tool for intercepting and manipulating HTTP traffic, including cookies.
- **Cookie Editor (browser extension):** Allows easy viewing and modification of browser cookies.
- **Browser DevTools (F12):** Provides built-in capabilities for inspecting and editing cookies.
- **Online Hash Decryption Tools (e.g., CrackStation):** Can be used to attempt to reverse weak hashing algorithms.

> **Remember:** Cookies are stored on the client side—never rely on them for access control or trust their contents without strict server-side validation.