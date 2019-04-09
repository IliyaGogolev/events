*****
* Install
******
npm install -g @google-cloud/functions-emulator
npm install -g firebase-tools
firebase setup:emulators:database

*********************
* functions-emulator config
*********************
/Users/iliya/.config/configstore/@google-cloud/functions-emulator
cat /Users/iliya/.config/configstore/@google-cloud/functions-emulator/config.json

firebase setup:emulators:firestore
firebase setup:emulators:database

function deploy
firebase deploy --only functions
firebase experimental:functions:shell
firebase serve
firebase --open-sesame emulators

functions inspect helloWorld
functions inspect someMethod1
functions inspect someMethod1 --port 6000



********************
* Kill all node 
********************
sudo pkill -f node

********************
* Debug firebase functions
********************
https://medium.com/@mwebler/debugging-firebase-functions-with-vs-code-3afab528bb36


********************
* Functions local
********************
https://firebase.google.com/docs/functions/local-emulator

$> firebase login
// emulate hosting and functions on locally hosted URLs.
$> firebase serve --only functions

$> functions start
$> 
$> firebase --open-sesame emulators
$> functions debug fun_name

Then restart the emulator. You can also check for any renegade
Node.js emulator processes that may need to be killed:

ps aux | grep node

****************
* check node 
****************
http://localhost:5000/json/version

FIREBASE_CONFIG="{\"databaseURL\":\"https://event2go-1234.firebaseio.com\",\"storageBucket\":\"event2go-1234.appspot.com\",\"projectId\":\"event2go-1234\"}"

FIREBASE_CONFIG="{\"databaseURL\":\"https://event2go-1234.firebaseio.com\",\"storageBucket\":\"event2go-1234.appspot.com\",\"projectId\":\"event2go-1234\"}" functions deploy --trigger-http --timeout 600s someMethod1

call:
set FIREBASE_CONFIG="{\"databaseURL\":\"https://event2go-1234.firebaseio.com\",\"storageBucket\":\"event2go-1234.appspot.com\",\"projectId\":\"event2go-1234\"}" 
functions deploy --trigger-http --timeout 600s someMethod1


***
* Troubleshooting 
*** 
1. firebase Failed to load gRPC binary module because it was not installed for the current system
Solution: run $> npm rebuild


******************
March 31, 2019
******************
Run local function, generated key:
export GOOGLE_APPLICATION_CREDENTIALS=../event2go-1234-715f9cdbbe4c.json 

In case of grpc build error, do:
1. rm -r $HOME/.node-gyp
2. npm i -S grpc

Get admin config
$>firebase setup:web

console.log(JSON.stringify(JSON.stringify({
  "apiKey": "AIzaSyBO1ahb1TOR5NHqb-BFfl3tSueqJEnM1yU",
  "databaseURL": "https://event2go-1234.firebaseio.com",
  "storageBucket": "event2go-1234.appspot.com",
  "authDomain": "event2go-1234.firebaseapp.com",
  "messagingSenderId": "894550020348",
  "projectId": "event2go-1234"
})))


///  REBUILD Node (rebuild lib folder)
$> npm run build
$> npm --prefix functions run build

// Rebuild  (lib folder) and deploy
$> firebase deploy --only functions


1. npm run build
2. functions deploy CCCC  --trigger-http
3. functions inspect CCCC
4. chrome://inspect
5. Source, add lib folder
6. functions call CCCC
