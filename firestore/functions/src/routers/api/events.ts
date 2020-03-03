
const express1 = require('express');
var eventsRouter = express1.Router();
const admin1 = require('firebase-admin');

// Example: 
// {
// 	"confirm_attending_type": "days",
// 	"confirm_attending_val": 12,
// 	"description": "My aaa event",
// 	"location": {
// 		"latitude": 32.163345,
// 		"longitude": -118.379921
// 	},
// 	"location_name": "Topange mall",
// 	"name": "Test event",
// 	"end_at": "2013-09-29T18:46:19-0700",
// 	"start_at": "2013-09-29T18:46:19-0000"
// }
eventsRouter.post('/', (req, res) => {
    
    const db = admin1.firestore();
    const jsonData = req.body;

    let point
    try {
        point = new admin1.firestore.GeoPoint(jsonData.location.latitude,jsonData.location.longitude)
    } catch(error) {
        res.status(400).json({ msg: `Argument is not a valid number.`, error: error.message})
        return
    }

    let data = {
        name : jsonData.name,
        description : jsonData.description, 
        confirm_attending_type : jsonData.confirm_attending_type,
        confirm_attending_val : jsonData.confirm_attending_val,        
        location : point,
        location_name : jsonData.location_name,
        end_at : new Date(jsonData.end_at),
        start_at: new Date(jsonData.start_at),     
        created_at: new Date(), 
        // created_at: admin1.firestore().FieldValue.serverTimestamp()

    }

    db.collection("events").add(data)
    .then(function(docRef) {
        console.log("Event document written with ID: ", docRef.id);
        res.json({ id: docRef.id})
    })
    .catch(function(error) {
        console.error("Error writing event document: ", error);
        res.status(400).json({ msg: `No user with id ${req.params.id}`, error: error.message})
    });
});
// http://localhost:8010/event2go-1234/us-central1/api/event/6xM8X5mRmBhy4ccn291d
eventsRouter.get('/:id', (req, res) => {

    let stuff = [];	
	const db = admin1.firestore();

    db.collection("events").doc(req.params.id).get().then(snapshot => {

		 console.log('snapshot ' + snapshot);
		 if (snapshot.exists) {
			res.json(snapshot.data());
		 } else {
			res.status(400).json({ msg: `No event with id ${req.params.id}`})
		 }
		
    }).catch(reason => {
		res.status(400).json({ msg: `No event with id ${req.params.id}`, error: reason.message})
    })
});

eventsRouter.delete('/:id', (req, res) => {
    let stuff = [];	
    const db = admin1.firestore();
    
    // var sessionsRef = firebase.database().ref("sessions");
// sessionsRef.push({
// startedAt: firebase.database.ServerValue.TIMESTAMP // this will write 'startedAt: 1537806936331`
// });

    const eventId = req.params.id;
    if (!eventId) throw new Error('id is blank');

    db.collection("events").doc(eventId).get().then(snapshot => {

        console.log('snapshot ' + snapshot);
        if (!snapshot.exists) {
           res.status(400).json({"success":false,  msg: `No event with id ${req.params.id}`})
        }
       
   }).catch(reason => {
       res.status(400).json({"success":false, msg: `No event with id ${req.params.id}`, error: reason.message})
   })

    db.collection("events").doc(eventId).delete().then(function() {
		res.json({"success":true});
    }).catch(reason => {
        res.status(400).json({ "success":false, msg: `No event with id ${req.params.id}`, error: reason.message})
    })
});

module.exports = eventsRouter;