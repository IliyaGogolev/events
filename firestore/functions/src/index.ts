import * as functions from 'firebase-functions';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//

// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.

const admin = require('firebase-admin');
admin.initializeApp();
const settings = {/* your settings... */ timestampsInSnapshots: true};
admin.firestore().settings(settings);

 export const helloWorld = functions.https.onRequest((request, response) => {
  // response.send("Hello from Firebase!");
  response.status(200).send('Hello, World!');
 });



exports.someMethod1 = functions.https.onRequest((req, response) => {
    console.log('Start');
     // response.status(200).send('Hi san!');

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
			response.json(snapshot.data());
		 } else {
			response.json();
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
		
		response.json(reason.messages);
		
	})
});


// const functions = require('firebase-functions');

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
