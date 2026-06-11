class PostAuthor {
  late String uid;
  late String displayName;
  late String? photoUrl;
  late String fcmToken;

  PostAuthor({
    required this.uid,
    required this.displayName,
    required this.photoUrl,
    required this.fcmToken,
  });

  PostAuthor.fromMap({required Map<String, dynamic> json}) {
    // uid = json['uid'];
    displayName = json['displayName'];
    photoUrl = json['photoUrl'];
    fcmToken = json['fcmToken'];
  }
}
