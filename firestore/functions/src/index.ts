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

// Example 
// https://github.com/firebase/functions-samples/blob/master/authorized-https-endpoint/functions/index.js

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


// Todo: check for session
// https://stackoverflow.com/questions/42751074/how-to-protect-firebase-cloud-function-http-endpoint-to-allow-only-firebase-auth
// Express middleware that validates Firebase ID Tokens passed in the Authorization HTTP header.
// The Firebase ID token needs to be passed as a Bearer token in the Authorization HTTP header like this:
// `Authorization: Bearer <Firebase ID Token>`.
// when decoded successfully, the ID Token content will be added as `req.user`.
const validateFirebaseIdToken = async (req, res, next) => {
  console.log('Check if request is authorized with Firebase ID token');

  if ((!req.headers.authorization || !req.headers.authorization.startsWith('Bearer ')) &&
      !(req.cookies && req.cookies.__session)) {
    console.error('No Firebase ID token was passed as a Bearer token in the Authorization header.',
        'Make sure you authorize your request by providing the following HTTP header:',
        'Authorization: Bearer <Firebase ID Token>',
        'or by passing a "__session" cookie.');
    res.status(403).send('Unauthorized');
    return;
  }

  let idToken;
  if (req.headers.authorization && req.headers.authorization.startsWith('Bearer ')) {
    console.log('Found "Authorization" header');
    // Read the ID Token from the Authorization header.
    idToken = req.headers.authorization.split('Bearer ')[1];
  } else if(req.cookies) {
    console.log('Found "__session" cookie');
    // Read the ID Token from cookie.
    idToken = req.cookies.__session;
  } else {
    // No cookie
    res.status(403).send('Unauthorized');
    return;
  }

  try {
    const decodedIdToken = await admin.auth().verifyIdToken(idToken);
    console.log('ID Token correctly decoded', decodedIdToken);
    req.user = decodedIdToken;
    next();
    return;
  } catch (error) {
    console.error('Error while verifying Firebase ID token:', error);
    res.status(403).send('Unauthorized');
    return;
  }
};


// APIs
// app.use(validateFirebaseIdToken);
app.use('/user', require('./routers/api/users'));
app.use('/event', require('./routers/api/events'));
exports.api = functions.https.onRequest(app);
