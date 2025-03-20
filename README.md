# Darkley-42

## Project Description
This project introduces you to the basics of cybersecurity, specifically focusing on vulnerabilities commonly found on websites. You'll explore real-world security risks and learn how to identify and exploit them by auditing a vulnerable website. The aim is to help you understand common security flaws such as SQL injection, cross-site scripting (XSS), and more. Throughout the project, you'll apply your knowledge to identify and exploit breaches, working through different challenges in a controlled environment.

The project will be evaluated on your ability to demonstrate and explain the solutions you find for each breach, with a specific focus on understanding the vulnerabilities rather than using automated tools. If you complete the mandatory part of the project perfectly, you'll be eligible for the bonus part, which involves providing advanced explanations of the most recognized breaches.

### [00-IDOR](https://github.com/Aramxxx8691/Darkley-42/blob/master/00-IDOR/Resources/README.md)  
Identifies direct object reference vulnerabilities allowing unauthorized access to data.
### [01-Open Redirect](https://github.com/Aramxxx8691/Darkley-42/blob/master/01-Open%20Redirect/Resources/README.md)  
Exploits vulnerable redirects to lead users to malicious sites.
### [02-Insecure Cookie Handling](https://github.com/Aramxxx8691/Darkley-42/blob/master/02-Insecure%20Cookie%20Handling/Resources/README.md)  
Finds improper cookie management leading to potential session hijacking.
### [03-HTTP Header Manipulation](https://github.com/Aramxxx8691/Darkley-42/blob/master/03-HTTP%20Header%20Manipulation/Resources/README.md)  
Modifies HTTP headers to bypass security measures or access hidden resources.
### [04-Value Manipulation](https://github.com/Aramxxx8691/Darkley-42/blob/master/04-Value%20Manipulation/Resources/README.md)  
Alters input values to perform unauthorized actions or gain access.
### [05-Mime Spoofing](https://github.com/Aramxxx8691/Darkley-42/blob/master/05-Mime%20Spoofing/Resources/README.md)  
Fakes file types to bypass file upload restrictions.
### [06-Hidden Files Scraping](https://github.com/Aramxxx8691/Darkley-42/blob/master/06-Hidden%20Files%20Scraping/Resources/README.md)  
Scans for and exposes hidden files within a web server's directories.
### [07-Brute Force](https://github.com/Aramxxx8691/Darkley-42/blob/master/07-Brute%20Force/Resources/README.md)  
Uses automated attempts to guess passwords or access points.
### [08-Dir Access Attack](https://github.com/Aramxxx8691/Darkley-42/blob/master/08-Dir%20Access%20Attack/Resources/README.md)  
Manipulates URLs to access restricted directories.
### [09-Restrict access](https://github.com/Aramxxx8691/Darkley-42/blob/master/09-Restrict%20access/Resources/README.md)  
Attempts to restrict unauthorized access to sensitive data or areas.
### [10-SQL Injection of Image](https://github.com/Aramxxx8691/Darkley-42/blob/master/10-SQL%20Injection%20of%20Image/Resources/README.md)  
Exploits SQL injection vulnerabilities in image handling processes.
### [11-SQL Injection of User](https://github.com/Aramxxx8691/Darkley-42/blob/master/11-SQL%20Injection%20of%20User/Resources/README.md)  
Executes SQL injection to manipulate user data within databases.
### [12-Stored XSS](https://github.com/Aramxxx8691/Darkley-42/blob/master/12-Stored%20XSS/Resources/README.md)  
Injects malicious scripts into webpages that are stored and executed later.
### [13-Reflected XSS](https://github.com/Aramxxx8691/Darkley-42/blob/master/13-Reflected%20XSS/Resources/README.md)  
Injects malicious scripts into requests that reflect back in web responses.

## Commands us

### Nikto (Web Server Vulnerability Scanner)
```
nikto -h http://target.com
```
This command scans the target web server for vulnerabilities.

### Dirb (Web Directory Brute-force Scanner)
```
dirb http://target.com /usr/share/wordlists/dirb/common.txt\
```
This command performs a brute-force scan to discover hidden directories on the target web server using the provided wordlist.

### Hydra (Password Brute-force Tool)
```
hydra -l admin -P passwords.txt ssh://target.com
```
This command attempts to perform a brute-force SSH login with the username admin and passwords from the passwords.txt wordlist.
