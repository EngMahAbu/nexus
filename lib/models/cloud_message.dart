enum CloudMessageType { postLike, postComment, postShare }

class CloudMessage {
  late String name; // server-generated id
  late Map<String, dynamic> data;
  late NotificationData notification;
  String? token;
  String? topic;

  CloudMessage.withToken({
    required this.data,
    required this.notification,
    required this.token,
  });

  CloudMessage.withTopic({
    required this.data,
    required this.notification,
    required this.topic,
  });

  CloudMessage.fromMap(Map<String, dynamic> messageMap) {
    name = messageMap['name'];
    data = messageMap['data'];
    notification = NotificationData.fromMap(messageMap['notification']);
    token = messageMap['token'];
    token = messageMap['topic'];
  }

  Map<String, dynamic> toMap() {
    return {
      "message": {
        // "name": name,
        "data": data,
        "notification": notification.toMap(),
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
  String? title;
  String? body;
  String? image;

  NotificationData({this.title, this.body, this.image});

  NotificationData.fromMap(Map<String, dynamic> notificationMap) {
    title = notificationMap['title'];
    body = notificationMap['body'];
    image = notificationMap['image'];
  }

  Map<String, dynamic> toMap() {
    return {"title": title, "body": body, "image": image};
  }
}
