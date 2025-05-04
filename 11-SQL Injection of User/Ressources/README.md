# 11-SQL Injection in User Search

## 🧠 What is SQL Injection?
**SQL Injection (SQLi)** is a web security vulnerability that allows attackers to interfere with the queries that an application makes to its database. By crafting malicious SQL statements, attackers can bypass security measures, view sensitive data, modify or delete data, execute arbitrary administrative operations on the database, and in some cases, even take over the server. It consistently ranks among the top web security risks identified by OWASP.

---

## 🔍 Scenario: Exploiting an Unprotected User Search Form
In this scenario, the user search functionality of the web application is vulnerable to SQL injection. Similar to the previous image search vulnerability, user-provided input is not properly sanitized before being incorporated into SQL queries.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:
1. 🕵️‍♂️ **Identifying the Vulnerable Endpoint:** The attacker identifies the user search page, likely accessible via a URL parameter like `/index.php?page=searchuser` or a similar name. Observing the form submission process reveals that user input is directly used in a database query.
2. 💉 **Initial Injection for Schema Discovery:** To understand the database structure, the attacker injects SQL code designed to extract information about tables and columns using a `UNION SELECT` statement:
```sql
1 OR 1=1 UNION SELECT table_name, column_name FROM information_schema.columns
```
This injection helps identify a table named users and its columns: user_id, first_name, last_name, town, country, planet, Comment, and countersign.
3. 🔓 **Extracting Relevant Data:** With knowledge of the table and column names, the attacker crafts a further `SQL injection query` to extract specific data, particularly the Comment and countersign:
```sql
1 OR 1=1 UNION SELECT Comment, countersign FROM users
```
4. 🔑 **Discovering the Flag Hint:** By examining the extracted comments, the attacker finds a crucial instruction: "Decrypt this password -> then lower all the char. `Sh256` on it and it's good!". This comment is associated with a value in the countersign field.
5. 🗝️ **Decrypting and Processing the Password:** Assuming the attacker successfully extracts the encrypted password from the countersign field, they obtain the string `"FortyTwo"`.
6. 🛡️ **Lowercasing and Hashing:** Following the instructions in the comment, the attacker converts the decrypted string to lowercase, resulting in `"fortytwo"`. They then calculate the `SHA-256 hash` of this lowercase string using a tool like shasum:
```bash
echo -n fortytwo | shasum -a 256
```
This command produces the flag.

---

## 🛡️ How to Defend Against SQL Injection
### ✅ Secure Development Principles
- N**ever trust user input directly in SQL queries:** Treat all user-provided data as potentially malicious.
- **Principle of Least Privilege for Database Access:** Grant the application database user only the necessary permissions.
### 🛠️ Technical Controls
- **Prepared Statements** (Parameterized Queries): This is the most effective way to prevent `SQL injection`. Prepared statements separate the SQL structure from the user-provided data. The database treats the data as parameters, preventing it from being interpreted as executable `SQL code`.
- **Input Sanitization and Validation:** While not a foolproof defense on its own, rigorously validating and sanitizing user input can help reduce the attack surface. This includes checking data types, formats, and lengths, and escaping potentially dangerous characters. However, relying solely on blacklisting characters is generally insufficient.
- **Use of Object-Relational Mappers** (ORMs): ORMs often provide `built-in protection` against SQL injection by abstracting database interactions and using parameterized queries under the hood.
- **Web Application Firewall** (WAF): A WAF can help `detect and block` malicious SQL injection attempts by analyzing HTTP traffic and identifying suspicious patterns.
- **Regular Security Audits and Penetration Testing:** Regularly assess the application for SQL injection vulnerabilities and other security flaws.
- **Error Handling:** Avoid displaying detailed database error messages to users, as this can provide attackers with valuable information about the database structure.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | SQL Injection                              |
| 📍 Example       | Exploiting a user search form to extract a flag |
| ⚠️ Risk          | Data breaches, data manipulation, server compromise |
| 🛡️ Fix           | Prepared statements, input validation, ORMs, WAF |

---

## ⚙️ Tools and Resources
- **Web Browser:** Used to interact with the web application.
SQL Injection Testing Tools (e.g., SQLMap): Automated tools for detecting and exploiting SQL injection vulnerabilities.
- **Burp Suite or OWASP ZAP:** Proxy tools for intercepting and modifying HTTP requests, aiding in manual SQL injection testing.
- **Online Hash Calculators:** Used to generate SHA-256 hashes.
- **Database Documentation:** Understanding the specific SQL syntax of the target database is crucial for advanced exploitation.

> **Remember:** Even a simple input field can be a gateway for attackers — always implement secure coding practices like using prepared statements and rigorous input validation.
