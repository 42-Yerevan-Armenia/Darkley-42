# 03-HTTP Header Manipulation

## 🧠 What is HTTP Header Manipulation?
**HTTP Header Manipulation** occurs when an attacker can influence the values of HTTP headers exchanged between a client (e.g., a web browser) and a server. While not always a direct vulnerability itself, manipulating certain headers can be a vector for various attacks, such as `Cross-Site Scripting (XSS)`, cache poisoning, or session fixation, depending on how the application processes these headers.

---

## 🔍 Scenario: Exploiting `src` Parameter with a Data URI
In this case, clicking on the NSA logo leads to a page where an image is loaded using a URI specified in the `src` parameter:
```
http://10.12.250.232/index.php?page=media&amp;src=nsa
```
The vulnerability arises because the application seems to directly use the value of the `src` parameter to load a resource. By leveraging the `data:` URI scheme, which allows embedding data directly within a URI, we can inject and execute arbitrary scripts.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:

1. 🕵️‍♂️ **Identify the Vulnerable Parameter:** Observe how the application loads resources. In this case, the `src` parameter in the URL appears to control the resource being fetched.
2. 💡 **Understand Data URIs:** Recognize that `data:` URIs provide a way to include data inline within a document. The syntax is:
```
data:[&lt;MIME type>][;base64],&lt;data>
```
- `<MIME type>`: Specifies the type of the data (e.g., `text/html`, `image/png`).
- `;base64`: An optional flag indicating that the `<data>` is Base64-encoded.
- `<data>`: The actual content of the resource.
3. ✍️ **Craft the Malicious Payload:** Our goal is to execute JavaScript. Therefore, we'll use the `<script>` tag:
```html
<script>alert('toto')</script>
```
4. **⚙️ Base64 Encode the Payload:** Since the data will be part of a URI, it's often necessary (or at least safer for transmission) to Base64 encode it:
```
echo '<script>alert(\'toto\')</script>' | base64
```
`This yields:PHNjcmlwdD5hbGVydCgndG90bycpPC9zY3JpcHQ+`

5. **🔗 Construct the Malicious URI:** Combine the data: scheme, the appropriate MIME type (text/html in this case, as <script> tags are part of HTML), the base64 encoding flag, and the encoded payload:
`data:text/html;base64,PHNjcmlwdD5hbGVydCgndG90bycpPC9zY3JpcHQ+`
6. **💉 Inject the Payload:** Replace the original src value (nsa) in the URL with our crafted data URI:
[http://10.12.250.232/index.php?page=media&src=data:text/html;base64,PHNjcmlwdD5hbGVydCgndG90bycpPC9zY3JpcHQ](http://10.12.250.232/index.php?page=media&src=data:text/html;base64,PHNjcmlwdD5hbGVydCgndG90bycpPC9zY3JpcHQ)
7. **💥 Trigger Execution:** When this modified URL is accessed, if the application directly renders the content pointed to by the src parameter without proper sanitization, the browser will interpret the data: URI as HTML and execute the embedded <script> tag, resulting in an alert box displaying "toto".

---

## 🛡️ How to Defend Against This Type of Manipulation
### ✅ Secure Development Principles
- Never directly use user-supplied input to load or include resources without strict validation and sanitization.
- Avoid relying on client-side identifiers to determine which resources to serve.
- Implement the principle of least privilege: only provide the necessary access to resources.

### 🛠️ Technical Controls
- **Use a `database` or a controlled mapping mechanism** to associate identifiers with resources: Instead of directly using the src parameter, use it as an index to look up the actual resource path in a secure backend system.
- Implement **strict server-side validation and sanitization** of all user inputs: If user input must influence resource loading, ensure it conforms to a very strict whitelist of allowed values and formats.
- Set appropriate **Content Security Policy (CSP)** headers: CSP can restrict the sources from which content can be loaded, including inline data. This can help mitigate the impact of data URI-based XSS. For example, you might restrict the data: scheme or disallow inline scripts.
- A**void rendering user-controlled data** in contexts where it can be interpreted as executable code (HTML, JavaScript, CSS).

---

## ✅ Summary
| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | HTTP Header Manipulation (leading to XSS via data URI)                              |
| 📍 Example       | Injecting a script using a data: URI in the src parameter |
| ⚠️ Risk          | Cross-Site Scripting (XSS), arbitrary code execution in the user's browser |
| 🛡️ Fix           | Server-side resource mapping, strict input validation, CSP |

---

## ⚙️ Tools and Resources
- **Web Browser Developer Tools (F12):** Essential for inspecting HTTP requests and responses and manipulating URL parameters.
- **Base64 Encoder/Decoder:** Useful for encoding and decoding payloads for data URIs.
- **Burp Suite or OWASP ZAP:** Can be used to intercept and modify HTTP requests to test the vulnerability.
- **Online CSP Evaluators:** To help craft and test Content Security Policy headers.

> **Remember:** While the example focuses on the src parameter, similar vulnerabilities can arise in other HTTP headers or URL parameters if user-controlled values are directly used to load or influence the rendering of content without proper security measures.