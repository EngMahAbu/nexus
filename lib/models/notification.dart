import 'package:nexus/models/cloud_message.dart';
import 'package:nexus/shared/date_time_helper.dart';

class Notification {
  String? id; // output (received) only
  late String name; // cloud server-generated id
  late CloudMessage message;
  late String senderUid;
  late String sendDate;

  Notification({
    this.id,
    required this.name,
    required this.message,
    required this.senderUid,
    required this.sendDate,
  });

  Notification.fromMap(Map<String, dynamic> messageMap) {
    name = messageMap['name'];
    message = CloudMessage.fromMap(messageMap['message']);
    senderUid = messageMap['senderUid'];
    sendDate = DateTimeHelper.formatTime(messageMap['sendDate']);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "message": message.toMap(),
      "senderUid": senderUid,
      "sendDate": sendDate,
    };
  }
}
