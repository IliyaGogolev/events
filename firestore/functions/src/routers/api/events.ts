
const express1 = require('express');
var eventsRouter = express1.Router();
const admin1 = require('firebase-admin');

// http://localhost:8010/event2go-1234/us-central1/api/event/
// body example:
// {
// 	"confirm_attending_type": "days",
// 	"confirm_attending_val": 2,
// 	"description": "My awesome event",
// 	"location": {
// 		"latitude": 34.163345,
// 		"longitude": -118.379921
// 	},
// 	"location_name": "Topange mall",
// 	"name": "Test event",
// 	"end_at": "",
// 	"start_at": ""
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

    let d = new Date();
    let date = {
        name : jsonData.name,
        description : jsonData.description, 
        confirm_attending_type : jsonData.confirm_attending_type,
        confirm_attending_val : jsonData.confirm_attending_val,        
        loc : point,
        location_name : jsonData.location_name,
        // end_at : "",
        // start_at: ""        
        created_at: d.getTime()
    }

    db.collection("events").add(jsonData)
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

module.exports = eventsRouter;