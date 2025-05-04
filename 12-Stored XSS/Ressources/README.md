# 12-Stored Cross-Site Scripting (XSS)

## 🧠 What is Stored Cross-Site Scripting (XSS)?
**Stored XSS**, also known as persistent XSS, is a type of Cross-Site Scripting vulnerability where malicious scripts are injected and permanently stored on the target server (e.g., in a database, message forums, comment sections, etc.). When other users access the affected page, the stored malicious script is executed in their browsers, potentially leading to session hijacking, defacement, or the redirection to malicious websites.

---

## 🔍 Scenario: Injecting JavaScript via a Feedback Form
In this scenario, a feedback form on the web application is vulnerable to stored `XSS`. User input provided in the feedback message is not properly sanitized before being stored in the database. Consequently, an attacker can inject a malicious script that will be executed whenever other users view the feedback section.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:
1. ✍️ **Identifying the Vulnerable Input:** The attacker identifies the feedback form as a potential entry point for injecting malicious content. The message field is a likely target, as it allows users to input arbitrary text.
2. 💉 **Crafting the Malicious Payload:** The attacker creates a `JavaScript` payload designed to achieve a malicious goal. In this simplified example, the goal is to reveal a flag when the word "script" is entered:

```javascript
<script>
  if (document.body.innerText.includes('script')) {
    alert('Flag revealed!');
    // In a real attack, this could be more malicious,
    // like stealing cookies or redirecting the user.
  }
</script>
```
3. 📤 **Injecting the Payload:** The attacker submits the feedback form with the malicious JavaScript code embedded within the message field. In this specific, somewhat contrived example, simply entering the word "script" triggers the vulnerability due to a lack of proper output encoding. A more realistic attack would involve injecting actual `JavaScript` tags.
4. 💾 **Storing the Payload:** The web application, lacking proper input sanitization, stores the attacker's malicious script directly into the feedback table in the database.
5. 💥 **Triggering the Attack on Other Users:** When other users navigate to the page displaying the feedback, the stored malicious script is retrieved from the database and rendered within the HTML content of the page. Their browsers then execute this script. In this case, if the rendered feedback contains the word `"script"`, an alert box with "Flag revealed!" will appear. 

In a real-world scenario, the injected script could perform more harmful actions on the victim's browser.

---

## 🛡️ How to Defend Against Stored XSS
### ✅ Secure Development Principles
- **Never trust user input:** All data coming from the client should be treated as potentially malicious.
- **Output Encoding/Escaping:** Encode or escape user-provided data before rendering it in HTML. This ensures that any potentially malicious characters are treated as plain text and not as executable code.

### 🛠️ Technical Controls
- **Context-Aware Output Encoding:** Encode data based on where it's being rendered (HTML body, HTML attributes, JavaScript context, CSS, etc.). Different contexts require different encoding schemes. For HTML content, HTML entity encoding is crucial `(e.g., < becomes &lt;, > becomes &gt;, " becomes &quot;, ' becomes &#x27;, & becomes &amp;)`.
- **Input Sanitization (with caution):** While output encoding is the primary defense, input `sanitization` can be used as a secondary measure to remove or modify potentially dangerous input. However, sanitization is complex and can be bypassed if not implemented correctly. It's generally safer to encode on output.
- **Content Security Policy (CSP):** CSP is a powerful HTTP header that allows you to `control the sources` from which the browser is allowed to load resources (scripts, styles, images, etc.). Properly configured CSP can significantly reduce the impact of XSS attacks by preventing the execution of inline scripts and scripts from untrusted domains.
- **Use Framework Security Features:** Modern web development frameworks often provide built-in mechanisms for output encoding and protection against XSS. Utilize these features.
- **Regular Security Audits and Penetration Testing:** Regularly assess the application for XSS vulnerabilities.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | Stored Cross-Site Scripting (XSS)                              |
| 📍 Example       | Injecting JavaScript into a feedback form to trigger an alert |
| ⚠️ Risk          | Account takeover, data theft, website defacement, malware distribution |
| 🛡️ Fix           | Context-aware output encoding, Content Security Policy (CSP) |

---

## ⚙️ Tools and Resources
- **Web Browser:** Used to interact with the web application and observe the execution of injected scripts.
- **Burp Suite or OWASP ZAP:** Proxy tools for intercepting and modifying HTTP requests and responses, useful for injecting and testing `XSS` payloads.
- **XSS Payloads Database** (e.g., PortSwigger XSS Cheat Sheet): Collections of various XSS payloads for testing.
- **Content Security Policy (CSP) Evaluators:** Tools to help create and test CSP headers.

> **Remember:** Always encode user input before outputting it to the browser — stored XSS can silently affect every user who views the infected page, turning one user's malicious input into a mass compromise.
