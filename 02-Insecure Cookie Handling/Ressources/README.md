# 02-Insecure Cookie Handling
In this case, we found an insecurely stored admin cookie:
```
I_am_admin=68934a3e9455fa72420237eb05902327
```
### Steps to Exploit:
1. Extract the cookie value and identify that it is an `MD5` hash.
2. Use an online hash decryption tool like `CrackStation` to decode it.
3. The decrypted value is `"false"`, meaning the site checks this cookie for admin privileges.
4. Hash `"true"` using `MD5` to get:
```
md5("true") = b326b5062b2f0e69046810717534cb09
```
5. Modify the cookie value in the browser using developer tools or a tool like `EditThisCookie` and replace it with the new hash.
6. Refresh the page and gain unauthorized admin access.

### Impact:
- Attackers can escalate privileges to gain administrative control.
- Sensitive user data may be exposed if authentication relies on weakly hashed cookies.

### Prevention:
- Use secure and `HttpOnly` cookie attributes to prevent client-side modification.
- Store sensitive authentication data server-side rather than in cookies.
- Implement strong encryption instead of weak or reversible hashes.

## Tools/Sites:
- Burp Suite
- Cookie Editor
- Browser DevTools (F12)
