# 00-IDOR – Insecure Direct Object Reference

## 🧠 What is IDOR?
**IDOR (Insecure Direct Object Reference)** is a common web vulnerability where attackers can access or manipulate data by modifying direct references to objects (like user IDs, email addresses, or file names) without proper server-side authorization checks.

---

## 🔍 Scenario: "Forgot Password" Exploit
In this lesson, we abused a poorly protected **"Forgot Password"** form. The form included a **hidden email field** in the HTML, which was used to decide who should receive the password recovery email.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:
1. 🕵️‍♂️ Go to the **"Forgot Password"** page of the web app.
2. 🔧 Open **Developer Tools** in your browser (press `F12`) and switch to the **Elements** tab.
3. 🔍 Locate a hidden input field in the form that looks like this:
```html
<input type="hidden" name="email" value="email@example.com">
```
4. ✏️ Replace the value with another user’s email address, such as:
```html
<input type="hidden" name="email" value="admin@example.com">
```
5. 📩 Submit the form. If the backend doesn’t validate ownership of the email, it may:
    - Send the password reset email to the target user.
    - OR send the attacker a reset link for the victim account.

---

## 🛡️ How to Defend Against IDOR
### ✅ Secure Development Principles
- **Never trust client-side input**: Even hidden fields can be modified.
- Validate and **authorize** every user action **on the server**.
- Password recovery flows should always operate based on:
  - Authenticated user session
  - Secure tokens—not user-supplied input

### 🛠️ Technical Controls
- Use **secure, expiring tokens** (e.g. `JWT` or `UUID`) for password reset links.
- Do not expose sensitive identifiers like `emails` in hidden fields.
- Rate-limit and log suspicious activities (multiple reset attempts, fast form resubmissions).
- Sanitize and validate all form submissions strictly.

---

## ✅ Summary
| Key Aspect       | Details                                           |
|------------------|---------------------------------------------------|
| 🔓 Vulnerability | IDOR (Insecure Direct Object Reference)           |
| 📍 Example       | Manipulating hidden email field in reset form     |
| ⚠️ Risk          | Unauthorized password reset or account takeover   |
| 🛡️ Fix           | Server-side authorization + token-based recovery |

---

## ⚙️ Tools and Resources
- **Burp Suite:** Intercept and modify HTTP requests to test for unauthorized access to sensitive objects.
- **OWASP ZAP:** Open-source tool for scanning and exploring insecure object references.
- **Postman:** Useful for crafting custom API requests and testing different object IDs or user data.
- **Browser DevTools (F12):** Allows inspection and modification of hidden form fields directly in the browser.
- **Log files (server-side):** Monitoring logs can help detect unusual access patterns that suggest IDOR attempts.

> **Remember:** IDOR isn't just about forms. It can occur anywhere user input controls access to resources without authorization—URLs, APIs, files, etc.
