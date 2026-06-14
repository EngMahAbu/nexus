import 'package:nexus/models/cloud_message.dart';

class Notification {
  String? id; // output (received) only
  late String name; // cloud server-generated id
  late CloudMessage cloudMessage;
  late String senderUid;
  late String sendDate;

  Notification({
    this.id,
    required this.name,
    required this.cloudMessage,
    required this.senderUid,
    required this.sendDate,
  });

  Notification.fromMap(Map<String, dynamic> notificationMap) {
    name = notificationMap['name'];
    cloudMessage = CloudMessage.fromMap(notificationMap['cloudMessage']['message']);
    senderUid = notificationMap['senderUid'];
    sendDate = notificationMap['sendDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "cloudMessage": cloudMessage.toMap(),
      "senderUid": senderUid,
      "sendDate": sendDate,
    };
  }
}
