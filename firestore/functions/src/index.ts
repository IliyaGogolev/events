import * as functions from 'firebase-functions';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// const express = require('express');
// const cors = require('cors');

// const app = express();

// Automatically allow cross-origin requests
// app.use(cors({ origin: true }));
// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.

// var serviceAccount = require('event2go-1234-715f9cdbbe4c.json');

// admin.initializeApp();

const express = require('express');
const cors = require('cors');
const app = express();
var bodyParser = require('body-parser');
const logger = require('./middleware/logger');

// Automatically allow cross-origin requests
app.use(cors({ origin: true }));

//configure bodyparser
var bodyParserJSON = bodyParser.json();
var bodyParserURLEncoded = bodyParser.urlencoded({extended:true});

app.use(logger);
app.use(bodyParserJSON);
app.use(bodyParserURLEncoded);

const headers = require('./middleware/headers');
app.use(headers);

const admin = require('firebase-admin');
admin.initializeApp({
  "apiKey": "AIzaSyBO1ahb1TOR5NHqb-BFfl3tSueqJEnM1yU",
  "databaseURL": "https://event2go-1234.firebaseio.com",
  "storageBucket": "event2go-1234.appspot.com",
  "authDomain": "event2go-1234.firebaseapp.com",
  "messagingSenderId": "894550020348",
  "projectId": "event2go-1234"
});
const settings = {
	// credential: admin.credential.cert(serviceAccount),
	timestampsInSnapshots: true};
admin.firestore().settings(settings);


// APIs
app.use('/user', require('./routers/api/users'));

exports.api = functions.https.onRequest(app);
