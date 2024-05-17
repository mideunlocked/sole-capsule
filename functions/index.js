const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// Function to write to the 'notifications' collection
/**
 * Sends a push notification to the "broadcast" topic.
 * @param {string} data - The data of the notification.
 * @param {string} name - The title of the notification.
 * @param {string} description - The description/body of the notification.
 * @return {Promise<void>} - A promise indicating the completion of
 * sending the notification.
 */
function writeToNotifications(data) {
  // Add a document with the provided data to the 'notifications' collection
  return admin.firestore().collection("notifications").add(data);
}

exports.notifyNewProduct = functions.firestore.document("/products/{id}")
    .onCreate((snap, context) => {
      const data = snap.data();
      const name = data["name"];
      const image = data["productImages"][1];

      return admin.messaging().sendToTopic("broadcast", {
        notification: {
          title: `🚀 Introducing: ${name}`,
          body: `Explore our latest arrival – the ${name}! Elevate 
your style and performance today. Tap to shop now!`,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      }).then((value) => {
        return writeToNotifications({
          title: `🚀 Introducing: ${name}`,
          description: `Explore our latest arrival – the ${name}! Elevate 
your style and performance today. Tap to shop now!`,
          body: `Hey [Customer's Name],

We're excited to introduce our newest addition to the Sole Pod family: ${name}!
        
${name} is the latest innovation in footwear technology, designed to provide 
unparalleled comfort, style, and performance. Whether you're hitting the gym, 
pounding the pavement, or just strolling around town, these shoes are sure to 
elevate your experience.
        
        `,
          imageUrl: image,
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
        });
      }).catch((error) => {
        console.error("Error sending notification:", error);
        throw new Error("Error sending notification");
      });
    });

exports.notifyBroadcast = functions.firestore.document("/notifications/{id}")
    .onCreate((snap, context) => {
      const data = snap.data();
      const title = data["title"];
      const image = data["imageUrl"];
      const description = data["description"];

      return admin.messaging().sendToTopic("broadcast", {
        notification: {
          title: title,
          body: description,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
          image: image,
        },
      }).catch((error) => {
        console.error("Error sending notification:", error);
        throw new Error("Error sending notification");
      });
    });

