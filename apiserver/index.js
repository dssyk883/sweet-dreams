var express = require('express')
var mongojs = require('mongojs')
var app = express()
var db = require('./myDB.js')

app.use(express.json())
app.get('/', (req, res) => {
	console.log("HELLO");
	res.writeHead(200, {'Content-Type': 'text/html'});
	res.end('special sixyoungpeople sweetdreams api server - pushtest');
})

app.get('/getAll', (req, res) => {
  db.printAllInCollection("sleepDetails", function(docs){
    console.log("sleepDetails(test1): ", docs);
    res.send(docs)
  });
})

app.post('/getCollection', (req, res) => {
    db.printAllInCollection(req.body.name, function (docs) {
        res.send(docs)
    });
})

app.post('/getRecentDetails', (req, res) => {
    db.getRecentDetailsbyUserID(req.body.userID, function (docs) {
        res.send(docs)
    });
})

app.post('/insertSleepDetails', (req, res) => {
    if (req.body) {
        db.insertSleepDetails(req);
    }
    res.send(req.body);
})

app.post('/getAllDetails', (req, res) => {
    db.getDetailsbyUserID(req.body.userID, function (docs) {
        res.send(docs)
    });
})

app.post('/createCollection', (req, res) => {
    if (req.body.name) {
        //  var collectionName = req.body.name;
        db.createCollection(req);
    }
    res.status(201).send("Completed");
})

app.post('/insertToCollection', (req, res) => {
    if (req.body) {
        db.insertToCollection(req);
    }
    res.send(req.body);
})

app.post('/findDetailsOnDate', (req, res) => {
    if (req.body) {
        db.findDetailsonDate(req, function (docs) {
            res.send(docs);
            console.log(docs);
        });
    }   
})

app.post('/updateSleepDetails', (req, res) => {
    if (req.body) {
        db.updateSleepDetails(req);
    }
    res.send(req.body);
})


app.listen(3000, ()=>console.log("listening"));
