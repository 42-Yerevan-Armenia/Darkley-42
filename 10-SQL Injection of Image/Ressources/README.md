# 10-SQL Injection in Image Search

## 🧠 What is SQL Injection?
**SQL Injection (SQLi)** is a web security vulnerability that allows attackers to interfere with the queries that an application makes to its database. By crafting malicious SQL statements, attackers can bypass security measures, view sensitive data, modify or delete data, execute arbitrary administrative operations on the database, and in some cases, even take over the server. It consistently ranks among the top web security risks identified by OWASP.

---

## 🔍 Scenario: Exploiting an Unprotected Image Search Form
In this scenario, the image search functionality of the web application is vulnerable to SQL injection. User-provided input to the search form is not properly sanitized before being incorporated into SQL queries, allowing for malicious manipulation.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:
1. 🕵️‍♂️ **Identifying the Vulnerable Endpoint:** The attacker identifies the image search page, likely accessible via a URL parameter like `/index.php?page=searchimg`. Observing the form submission process reveals that user input is directly used in a database query.
2. 💉 **Initial Injection for Schema Discovery:** To understand the database structure, the attacker injects SQL code designed to extract information about tables and columns. This is often done using `UNION SELECT` statements to append the results of a malicious query to the legitimate results.

- **Discovering Table and Column Names:**
```sql
1 OR 1=1 UNION SELECT table_name, column_name FROM information_schema.columns
```
This injection attempts to retrieve the names of all tables and columns within the database. In this case, it helps identify a table named `list_images` and its columns: `id`, `url`, `title`, and `comment`.

3. 🔓 **Extracting Relevant Data:** With knowledge of the table and column names, the attacker crafts further SQL injection queries to extract specific data:

- **Retrieving Title and Comment:**
```sql
1 OR 1=1 UNION SELECT title, comment FROM list_images
```
or (in a blind SQLi scenario without error messages):
```sql
1 union all select 1, group_concat(comment, 0x0a) from list_images
```
The `group_concat` function is useful in blind SQLi to retrieve multiple rows of data into a single string, separated by a delimiter (here, `0x0a` for a newline character).
4. 🔑 **Discovering the Flag Hint:** By examining the extracted comments, the attacker finds a crucial hint: `"If you read this, just use this md5 decode lowercase then sha256 to win this flag! : 1928e8083cf461a51303633093573c46"`.
5. 🗝️ **Decoding and Hashing:** The hint provides an MD5 hash (`1928e8083cf461a51303633093573c46`). The attacker uses an online MD5 decryption tool (like [crackstation.net](https://crackstation.net)) to decode this hash, obtaining the lowercase string "albatroz".
6. 🛡️ **Generating the Flag:** Following the instructions in the comment, the attacker then calculates the SHA-256 hash of the decoded string "albatroz" using a tool like `shasum`:
```bash
echo -n albatroz | shasum -a 256
```

## 🛡️ How to Defend Against SQL Injection
### ✅ Secure Development Principles
- Never trust user input directly in SQL queries: Treat all user-provided data as potentially malicious.
- Principle of Least Privilege for Database Access: Grant the application database user only the necessary permissions.

### 🛠️ Technical Controls
- **Prepared Statements** (Parameterized Queries): This is the most effective way to prevent `SQL injection`. Prepared statements separate the `SQL structure` from the user-provided data. The database treats the data as parameters, preventing it from being interpreted as executable `SQL code`.
- **Input Sanitization and Validation:** While not a foolproof defense on its own, rigorously validating and sanitizing user input can help reduce the attack surface. This includes checking data types, formats, and lengths, and escaping potentially dangerous characters. However, relying solely on blacklisting characters is generally insufficient.
- **Use of Object-Relational Mappers (ORMs):** ORMs often provide built-in protection against SQL injection by abstracting database interactions and using parameterized queries under the hood.
- **Web Application Firewall (WAF):** A WAF can help `detect and block` malicious SQL injection attempts by analyzing HTTP traffic and identifying suspicious patterns.
- **Regular Security Audits and Penetration Testing:** Regularly assess the application for SQL injection vulnerabilities and other security flaws.
- **Error Handling:** Avoid displaying detailed database error messages to users, as this can provide attackers with valuable information about the database structure.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | SQL Injection                              |
| 📍 Example       | Exploiting an image search form to extract a flag |
| ⚠️ Risk          | Data breaches, data manipulation, server compromise |
| 🛡️ Fix           | Prepared statements, input validation, ORMs, WAF |

---

## ⚙️ Tools and Resources
- **Web Browser:** Used to interact with the web application.
- **SQL Injection Testing Tools** (e.g., SQLMap): Automated tools for detecting and exploiting SQL injection vulnerabilities.
- **Burp Suite or OWASP ZAP:** Proxy tools for intercepting and modifying `HTTP requests`, aiding in manual `SQL injection` testing.
- **Online MD5 Decryption Tools:** Used to reverse `MD5 hashes`.
- **Command-line tools** (echo, shasum): Used for hashing algorithms.
- **Database Documentation:** Understanding the specific `SQL syntax` of the target database is crucial for advanced exploitation.

> **Remember:** Always validate and sanitize input, use prepared statements, and never expose internal database errors — prevention is always better than exploitation.