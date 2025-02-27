# 01-Open Redirect
In this scenario, we found a social media link with a redirect parameter:

```
<a href="index.php?page=redirect&amp;site=facebook" class="icon fa-facebook"></a>
```
Since the site parameter controls the redirection destination, we can manipulate it to send users to a malicious website.

### Steps to Exploit:
1. Inspect the HTML and find the redirect parameter.
2. Modify the URL to replace facebook with an external malicious site:
```
http://target.com/index.php?page=redirect&site=evil.com
```
3. If the website does not validate the destination, clicking the link will redirect users to evil.com.

### Impact:
- Attackers can use this to trick users into visiting phishing sites.
- It can be combined with social engineering to steal credentials.
### Prevention:
- Validate and restrict redirect destinations to a whitelist.
- Use absolute URLs instead of allowing user-controlled parameters.

## Tools/Sites:
- Burp Suite
- OWASP ZAP
- URL Decoder/Encoder
