// import { user } from "firebase-functions/lib/providers/auth";

const express = require('express');
var usersRouter = express.Router();
const admin = require('firebase-admin');

// module.exports = function(router) {
    // router.post('/getEvent/:id', (req, res) => res.send(req.params.id));
		// userRouter.get('/:id', (req, res) => res.send(req.params.id));
usersRouter.get('/:id', (req, res) => {

    const users = [{
        id: `1`,
        name: `Iliya`,
        email: `korkag@gmail.com`
    }, {
        id: `2`,
        name: `Mike`,
        email: `mike@gmail.com`
    }]

    const found = users.some(user => user.id === req.params.id)
    if (found) {
        res.json(users.filter(user => user.id === req.params.id))
    } else {
        res.status(400).json({ msg: `No member with id ${req.params.id}`})
    }
});

usersRouter.get('/db/:id', (req, res) => {

    let stuff = [];	
	const db = admin.firestore();
	

// 	const comments = []
// firebase.firestore().collection('/comments').get().then(snapshot => {
//   snapshot.docs.forEach(doc => {
//     const comment = doc.data()
//     comment.userRef.get().then(snap => {
//       comment.user = snap.data()
//       comments.push(comment)
//     })
//   })
// })

    db.collection("events").doc("DqVjCk3WyWhLlPS7Aoa8").get().then(snapshot => {

		 console.log('snapshot ' + snapshot);
		 if (snapshot.exists) {
			// var returnArr = [];

			// snapshot.forEach(function(childSnapshot) {
			// 	var item = childSnapshot.val();
			// 	item.key = childSnapshot.key;

			// 	returnArr.push(item);
			// });

			//return returnArr;
			res.json(snapshot.data());
		 } else {
			res.json();
		 }
 		// if (snapshot.docs.length === 1) {
 	    //       	const newelement = {
	    //             "id": snapshot.doc.id,
	    //             "location_name": snapshot.doc.data().location_name,
	    //         }
	    //         stuff = stuff.concat(newelement);
		// } else {
	    //     snapshot.forEach(doc => {

	    //     	console.log('doc ' + doc);
	    //       	const newelement = {
	    //             "id": doc.id,
	    //             "location_name": doc.data().location_name,
	    //         }
	    //         stuff = stuff.concat(newelement);
		// 	});
		// }
        // }
			// response.status(200).send('Hello, World 1!');
		
    }).catch(reason => {
		console.log('BBB (1): ' + reason);
    	console.log('BBB (2): ' + reason.messages);
		
		res.json(reason.messages);
		
    })
});



// export const CCCC = functions.https.onRequest((request, response) => {
	// response.send("Hello from  AAA Firebase!");
	// admin.auth().getUserByPhoneNumber("+14085556969").then(
	// 	function(userRecord) {
	// 		console.log("Successfully fetched user data:", userRecord.toJSON());
	// 		response.status(200).send(userRecord.toJSON());
	// 	}).catch(function(error) {
	// 		console.log("Error fetching user data:", error);
	// 		response.status(200).send('Hello, World! ' + error.message);
	//  });

	// response.status(200).send("CCCC");
  
//  });




// The Firebase Admin SDK to access the Firebase Realtime Database.
// const admin = require('firebase-admin');
// admin.initializeApp();

// Take the text parameter passed to this HTTP endpoint and insert it into the
// Realtime Database under the path /messages/:pushId/original
//exports.addMessage = functions.https.onRequest((req, res) => {
  // Grab the text parameter.
//  const original = req.query.text;
  // Push the new message into the Realtime Database using the Firebase Admin SDK.
//  return admin.database().ref('/messages').push({original: original}).then((snapshot) => {
    // Redirect with 303 SEE OTHER to the URL of the pushed object in the Firebase console.
//    return res.redirect(303, snapshot.ref.toString());
//  });
//});




module.exports = usersRouter;
