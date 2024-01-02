/* eslint-disable linebreak-style */
const functions = require("firebase-functions");
// import admin module
const admin = require("firebase-admin");
admin.initializeApp();

// eslint-disable-next-line max-len
exports.sendNotificationForNewTrainee = functions.region("europe-west1").firestore.document("trainees/pending/data/{id}")
    .onCreate( async (event) => {
      console.log("Push notification event triggered");
      const valueObject = event.data();
      console.log("Trainer ID: " + valueObject.trainerID);
      // eslint-disable-next-line max-len
      await admin.firestore().collection("users").doc(valueObject.trainerID)
          .get().then(async (doc) => {
            console.log("Trainer Token: " + doc.data().token);
            const token = doc.data().token;
            console.log(token);
            const payload = {
              message: {
                token: token,
                notification: {
                  title: "طلب تدريب جديد",
                  body: "طلب تدريب جديد من " + valueObject.name,
                },
              },
              contentAvailable: true,
              priority: "high",
            };
            // eslint-disable-next-line max-len
            // const options = {
            //   priority: "high",
            //   timeToLive: 60 * 60 * 24,
            // };
            // eslint-disable-next-line max-len
            await admin.firestore().collection("users").doc(valueObject.trainerID).update({
              notification: true,
              notifications: admin.firestore.FieldValue.arrayUnion({
                title: "طلب تدريب جديد",
                body: "طلب تدريب جديد من " + valueObject.name,
                createsAt: admin.firestore.Timestamp.now(),
              }),
            }).then( async ()=> {
              await admin.messaging().send(payload.message).then((response) => {
                console.log("Successfully sent message:", response);
              // eslint-disable-next-line max-len
              }).catch((error) => {
                console.log("Error sending message:", error);
              });
            });
          });
    });


// eslint-disable-next-line max-len
exports.sendNotificationForupdateTraineeData = functions.region("europe-west1").firestore.document("trainees/{id}")
    .onUpdate(async (event) => {
      console.log("Push notification event triggered");
      const valueObject = event.after.data();
      // eslint-disable-next-line max-len
      console.log("data after: " + event.after.data().followUpList.length);
      // eslint-disable-next-line max-len
      console.log("data before: " + event.before.data().followUpList.length);
      const previousValueObject = event.before.data();
      console.log("Trainer ID: " + valueObject.trainerID);
      // check if lists are the same length
      // eslint-disable-next-line max-len
      if (valueObject.followUpList.length != previousValueObject.followUpList.length) {
        console.log("change in follow up list");
        return;
      }
      console.log("no change in follow up list");
      // eslint-disable-next-line max-len
      await admin.firestore().collection("users").doc(valueObject.uid)
          .get().then(async (doc) => {
            const token = doc.data().token;
            console.log("Token is : "+token);
            const payload = {
              message: {
                token: token,
                notification: {
                  title: "تم تحديث بياناتك",
                  body: "تم تحديث بياناتك من قبل المدرب",
                },
              },
            };
            // eslint-disable-next-line max-len
            await admin.firestore().collection("users").doc(valueObject.uid).update({
              notification: true,
              notifications: admin.firestore.FieldValue.arrayUnion({
                title: "تم تحديث بياناتك",
                body: "تم تحديث بياناتك من قبل المدرب",
                createsAt: admin.firestore.Timestamp.now(),
              }),
            }).then( async ()=> {
              await admin.messaging().send(payload.message).then((response) => {
                console.log("Successfully sent message:", response);
              // eslint-disable-next-line max-len
              }).catch((error) => {
                console.log("Error sending message:", error);
              });
            });
          });
    });


// eslint-disable-next-line max-len
exports.sendNotificationForNewTrainerToAdmins = functions.region("europe-west1").firestore.document("trainers/pending/data/{id}")
    .onCreate( async (event) => {
      console.log("Push notification event triggered");
      const valueObject = event.data();
      console.log("Trainer ID: " + valueObject.uid);
      await admin.firestore().collection("users").where("role", "==", "admin")
          .get().then(async (querySnapshot) => {
            querySnapshot.forEach(async (doc) => {
              const token = doc.data().token;
              console.log(token);
              const payload = {
                message: {
                  token: token,
                  notification: {
                    title: " طلب انضمام مدرب جديد",
                    body: "طلب انضمام مدرب جديد من " + valueObject.name,
                  },
                },
                android: {
                  priority: "high",
                },
                apns: {
                  headers: {
                    "apns-priority": "10",
                  },
                  contentAvailable: true,
                },
              };
              await admin.firestore().collection("users").doc(doc.id).update({
                notification: true,
                notifications: admin.firestore.FieldValue.arrayUnion({
                  title: " طلب انضمام مدرب جديد",
                  body: "طلب انضمام مدرب جديد من " + valueObject.name,
                  createsAt: admin.firestore.Timestamp.now(),
                }),
              }).then(async () => {
                // eslint-disable-next-line max-len
                await admin.messaging().send(payload.message).then((response) => {
                  console.log("Successfully sent message:", response);
                  // eslint-disable-next-line max-len
                }).catch((error) => {
                  console.log("Error sending message:", error);
                });
              });
            });
          });
    });

// eslint-disable-next-line max-len
exports.onEmailVerification = functions.auth.user().onUpdate(async (user) => {
  const {uid, emailVerified} = user.after;
  if (emailVerified) {
    console.log(`User with UID ${uid} has verified their email`);
    const userDocRef = admin.firestore().collection("users").doc(uid);
    await userDocRef.update({emailVerified: true});
    console.log(`Updated Firestore document for user with UID ${uid}`);
  } else {
    console.log(`User with UID ${uid} has unverified their email`);
  }
});
