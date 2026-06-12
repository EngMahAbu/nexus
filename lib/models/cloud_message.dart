enum CloudMessageType { postLike, postComment, postShare }

class CloudMessage {
  // late String name; // server-generated id
  late Map<String, dynamic> data;
  late NotificationData notificationData;
  String? token;
  String? topic;

  CloudMessage.withToken({
    required this.data,
    required this.notificationData,
    required this.token,
  });

  CloudMessage.withTopic({
    required this.data,
    required this.notificationData,
    required this.topic,
  });

  CloudMessage.fromMap(Map<String, dynamic> messageMap) {
    data = messageMap['data'];
    notificationData = NotificationData.fromMap(messageMap['notification']);
    token = messageMap['token'];
    token = messageMap['topic'];
  }

  Map<String, dynamic> toMap() {
    return {
      "message": {
        // "name": name,
        "data": data,
        "notification": notificationData.toMap(),
        // "android": {
        //   object (AndroidConfig)
        // },
        // "webpush": {
        //   object (WebpushConfig)
        // },
        // "apns": {
        //   object (ApnsConfig)
        // },
        // "fcm_options": {
        //   object (FcmOptions)
        // },

        // Union field target can be only one of the following:
        if (token != null) "token": token,
        if (topic != null) "topic": topic,
        // "condition": string
        // End of list of possible types for union field target.
      },
    };
  }
}

// Basic notification template to use across all platforms.
class NotificationData {
  String title;
  String body;
  String? image;

  NotificationData({required this.title, required this.body, this.image});

  NotificationData.fromMap(Map<String, dynamic> notificationDataMap)
    : title = notificationDataMap['title'],
      body = notificationDataMap['body'] {
    image = notificationDataMap['image'];
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "body": body, "image": image};
  }
}
