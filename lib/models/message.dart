import 'package:nexus/shared/date_time_helper.dart';

class Message {
  // Cloud fields
  late String senderUid;
  late String receiverUid;
  late String textContent;
  late List<dynamic>? imagesList;
  late String dateTime;

  Message({
    required this.senderUid,
    required this.textContent,
    required this.receiverUid,
    this.imagesList,
  }) {
    dateTime = DateTimeHelper.getCurrentDateTime();
  }

  Message.fromMap(Map<String, dynamic> postMap) {
    senderUid = postMap['senderUid'];
    receiverUid = postMap['receiverUid'];
    textContent = postMap['textContent'];
    imagesList = postMap['imagesList'];
    dateTime = postMap['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'textContent': textContent,
      'imagesList': imagesList,
      'dateTime': dateTime,
    };
  }
}
