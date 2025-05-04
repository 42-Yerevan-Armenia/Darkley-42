# 04-Value Manipulation

## 🧠 What is Value Manipulation?
**Value Manipulation** is a vulnerability that arises when a web application relies solely on client-side controls or insufficient server-side validation to restrict the range or format of user-submitted data. Attackers can bypass these client-side restrictions by intercepting and modifying the data before it reaches the server, potentially leading to unexpected or harmful behavior.

---

## 🔍 Scenario: Bypassing Survey Grade Limits
In this scenario, a survey page features a grading system that is intended to accept values only between 1 and 10. The HTML for the grade selection dropdown appears as follows:
```html
<select name="grade">
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="4">4</option>
    <option value="5">5</option>
    <option value="6">6</option>
    <option value="7">7</option>
    <option value="8">8</option>
    <option value="9">9</option>
    <option value="10">10</option>
</select>
```
However, the application might be vulnerable if it doesn't properly validate the submitted grade value on the server-side.

---

## 🧨 How the Attack Works
### Step-by-Step Exploitation:
1. 🕵️‍♂️ **Inspect the HTML:** Open the survey page in your browser and use the Developer Tools (press `F12`, navigate to the Elements tab) to examine the HTML structure, particularly the <select> element for the grade.
2. ✏️ **Modify Client-Side Controls:** There are several ways to manipulate the submitted value:
3. 🔧 **Direct HTML Modification:** Within the Developer Tools, you can directly edit the HTML of the <select> element. You can change the value attribute of existing <option> tags to values outside the 1-10 range, or you can add entirely new <option> tags with arbitrary values, such as:
```html
<option value="999">999</option>
<option value="-50">-50</option>
```
4. 🚨 **Intercept and Modify the Request:** Tools like `Burp Suite or Tamper Data` can be used to intercept the `HTTP` request sent when the survey form is submitted. You can then modify the grade parameter in the `request` body to any desired value before it reaches the server.
5. 📤 **Submit the Manipulated Data:** After modifying the value either in the `HTML` or by intercepting the `request`, submit the survey form.
6. 👀 **Observe the System's Response:** Analyze how the server-side application processes the out-of-range or unexpected value. Does it:
- Accept the value without any validation?
- Produce an error?
- Lead to incorrect calculations or data storage?

---

## 🛡️ How to Defend Against Value Manipulation
### ✅ Secure Development Principles
- **Never rely solely on client-side validation:** Client-side controls are easily bypassed.
- Implement **robust server-side validation** for all user inputs: This is the most critical defense.
- **Enforce strict data types and ranges:** Ensure that submitted values conform to the expected format and limitations.
- **Sanitize user input:** Remove or escape potentially harmful characters before processing or storing data.

### 🛠️ Technical Controls
- **Implement `server-side` input validation:** Use programming language features and libraries to define and enforce constraints on the grade parameter (e.g., ensuring it's an integer within the range of 1 to 10).
- **Use whitelisting for allowed values:** Instead of just checking for a range, explicitly define the acceptable values.
- **Employ prepared statements or parameterized queries:** While primarily for preventing SQL injection, they also help ensure that data is treated as data and not executable code, which can be relevant if manipulated values are used in database queries.
- Implement **input field restrictions** on the client-side as a user experience enhancement, but never as a security measure.

---

## ✅ Summary

| Key Aspect       | Details                                               |
|------------------|-------------------------------------------------------|
| 🔓 Vulnerability | Value Manipulation                              |
| 📍 Example       | Submitting out-of-range grades in a survey form |
| ⚠️ Risk          | Data integrity issues, broken calculations, privilege manipulation |
| 🛡️ Fix           | Robust server-side validation, data type enforcement |

---

## ⚙️ Tools and Resources
- **Burp Suite:** A powerful tool for intercepting and modifying HTTP requests and responses.
- **Tamper Data (Firefox extension):** A browser extension that allows you to modify HTTP/HTTPS requests.
- **Postman:** Primarily an API testing tool, but can also be used to craft and send arbitrary HTTP requests.
- **Browser DevTools (F12):** Useful for inspecting and modifying HTML form elements before submission.

> **Remember:** Client-side controls are for convenience, not security—attackers can easily bypass them, so always validate input rigorously on the server side.
