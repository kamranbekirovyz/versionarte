## 🚜 Firebase Remote Config setup guide

To use `RemoteConfigVersionarteProvider`, you must first set up Firebase Remote Config in your app. You can follow the <a href="https://firebase.google.com/docs/remote-config/get-started?platform=flutter">official Flutter guide</a> to set up Firebase Remote Config in your app.

Assuming you've already set up Firebase Remote Config in your app, below are steps on how to set up versionarte with Firebase Remote Config:

### Step 1: open Remote Config tab
Navigate to the Remote Config tab of the Firebase Console. You should see a screen similar to the one below:

### Step 2: Upload "versionarte" parameter.

1. Create a new Firebase Remote Config parameter in the Firebase console. The parameter name must be `versionarte` and the default value must be the JSON object that contains the versioning information for your app.