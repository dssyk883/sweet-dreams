# 🌙 Sweet Dreams - Sleep Data Tracker Mobile App

This repository archieves my personal contributions to Sweet Dreams, a cross-platform mobile application that allows users to record and track their sleep data with visual statistics and reminder features. It follows **Model-View-Presenter (MVP)** architecture and uses modern mobile and backend technologies including **Flutter**, **Express.js**, and **MongoDB**.


> ⚠️ Note: This repository is for archival purpose only. The source code here includes the entire work including those independently done by me (Soyeon Kwon). Please refer to [the final project presentation](./doc/final-presentation.pdf) for full team credits. 

---

## ✨ Features I Developed

### 📝 1. Sleep Logging Interface 
- Built a form for recording:
    - Sleep and wake-up times
    - Sleep quality (via slider)
    - Sleep and dream notes (via multiselectable widget)
- Handled input parsing and formatting before sending it to the backend
- API integration using functions in `api.dart` to communicate with the server

### 📆 2. View and Search Sleep History
- Developed a **calendar widget** to allow users to view past past sleep records. 
- Built a custom **search-by-date** functions using regular expressions in MongoDB.

### ⏰ 3. Alarm and Notification System
- Created a **sound notification alarm** that persists until the app is reopened
- Dynamically controlled widget visibility based on user actions like "Snooze"
- Triggered alarm/dream note inputs based on alarm state

### 🧩 4. UI Enhancements
- Refactored the main screen using a hamburger drawer widget
- Helped modularize UI logic in the **MVP** structure

### 🛠️ 5. Backend API (Express.js + MongoDB)
The backend is written in Node.js, uses Express.js for routing, and mongojs for database operations. Here's a simplified view of how data is managed:
```
// index.js
app.post('/insertSleepDetails', (req, res) => {
    if (req.body) {
        db.insertSleepDetails(req);
    }
    res.send(req.body);
});
```

```
// myDB.js
insertSleepDetails: function (sleepInfoObj, callback) {
    mongodb.collection("sleepDetails").insert({
        userID: sleepInfoObj.body.userID,
        sleepTime: sleepInfoObj.body.sleepTime,
        sleepNotes: sleepInfoObj.body.sleepNotes,
        sleepQuality: sleepInfoObj.body.sleepQuality,
        dreamNotes: sleepInfoObj.body.dreamNotes,
        wakeupTime: sleepInfoObj.body.wakeupTime
    }, callback);
}
```

The full set of backend endpoints include:
- `POST /insertSleepDetails`
- `POST /getAllDetails`
- `POST /getRecentDetails`
- `POST /updateSleepDetails`
- `POST /findDetailsOnDate`

---

## 📁 Tech Stack
- **Frontend:** Flutter & Dart
- **Backend:** Node.js with Express.js and `mongojs`
- **Database:** MongoDB
- **Web Server:** NGINX on AWS EC2
- **Architecture:** Model-View-Presenter (MVP)

## 👩‍💻 Author
Soyeon Kwon | MSCS Graduate | [LinkedIn](https://www.linkedin.com/in/soyeon-kwon-mscs-uci2025/)

This repository highlights my academic contributions to a collaborative mobile app project.