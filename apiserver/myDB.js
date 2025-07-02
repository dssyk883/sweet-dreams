const mongojs = require('mongojs'); //imports 'mongojs'
const assert = require('assert'); //Assertion for queries
// Connection URL
const url = "mongodb://sixyoungpeople:sixyoungpasswords@localhost:27017/cs3541";
//const url = "mongodb://localhost:27017/lab6";
//URL with database included for local mongo db
// Database Name
const collections=["sleepDetails"];
//list of collections that you will be accessing.
mongodb = mongojs(url, collections);
module.exports = {
    printAllInCollection : function(collectionName, callback){
        var cursor = mongodb.collection(collectionName).find({}).limit(10, function(err, docs){
            if(err || !docs) {
                console.log("Cannot print database or database is empty\n");
            }
            else {
                //console.log(collectionName, docs);
                callback(docs);
            }
        });
    },
   createCollection : function(collectionName, callback){
          mongodb.createCollection(collectionName.body.name, function(err, docs){
//        console.log(collectionName);
            if(err) {
                console.error(err);
            }
	    else{
               console.log("Created - ", collectionName.body.name);
            }
       });
    },
   insertToCollection : function(insertObj, callback){
         var changed = "{ hash: " + insertObj.body.hash;
         changed += "}"
	 mongodb.collection(insertObj.body.name).insert({
                                                         hash: insertObj.body.hash,
                                                         others: insertObj.body.other
                                                         }, function(err, docs){
         if(err){
               console.error(err);
          }
         else{
           console.log(insertObj.body);
          }
      });
  },


    getDetailsbyUserID: function (uID, callback) {
        var cursor = mongodb.collection("sleepDetails").find({ userID: uID }, function (err, docs) {

            if (err || !docs) {
                console.log("Cannot print database or database is empty\n");
            }
            else {
                //console.log(collectionName, docs);

                callback(docs);
            }
        });

    },

    getRecentDetailsbyUserID: function (uID, callback) {
        var cursor = mongodb.collection("sleepDetails").find({ userID: uID }).sort({ _id: -1 }).limit(1, function (err, docs) {

            if (err || !docs) {
                console.log("Cannot print database or database is empty\n");
            }
            else {
                //console.log(collectionName, docs);

                callback(docs);
            }
        });

    },

    insertSleepDetails: function (sleepInfoObj, callback) {
        var cursor = mongodb.collection("sleepDetails").insert({
            userID: sleepInfoObj.body.userID,
            sleepTime: sleepInfoObj.body.sleepTime,
            sleepNotes: sleepInfoObj.body.sleepNotes,
            sleepQuality: sleepInfoObj.body.sleepQuality,
            dreamNotes: sleepInfoObj.body.dreamNotes,
            wakeupTime: sleepInfoObj.body.wakeupTime
        }, function (err, docs) {
            if (err || !docs) {
                console.error(err);
            }
            else {
                console.log(sleepInfoObj.body);
            }
        });
    },

    findDetailsonDate: function (findInfo, callback) {
        var regdate = new RegExp('^' + findInfo.body.thisDate + '.*');
        console.log(regdate);
        var cursor = mongodb.collection("sleepDetails").find({
            userID: findInfo.body.userID,
            sleepTime: { '$regex': regdate }
        }, function (err, docs) {
            if (err || !docs) {
                console.error(err);
            }
            else {
                callback(docs);
            }
        });
    },

    updateSleepDetails: function (sleepInfoObj, callback) {
        var regdate = new RegExp('^' + sleepInfoObj.body.updateDate + '.*');
        console.log(regdate);
        var cursor = mongodb.collection("sleepDetails").update(
            {   
                userID: sleepInfoObj.body.userID,
                sleepTime: { '$regex': regdate }
            },
            {$set: {
                    userID: sleepInfoObj.body.userID,
                    sleepTime: sleepInfoObj.body.sleepTime,
                    sleepNotes: sleepInfoObj.body.sleepNotes,
                    sleepQuality: sleepInfoObj.body.sleepQuality,
                    dreamNotes: sleepInfoObj.body.dreamNotes,
                    wakeupTime: sleepInfoObj.body.wakeupTime
                }                
            },
            { upsert: true }
            
        , function (err, docs) {
            if (err || !docs) {
                console.error(err);
            }
            else {
                console.log(" - Update/Insertion completed");
            }
        });
    },
};
