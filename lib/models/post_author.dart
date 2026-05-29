class PostAuthor {
  late String displayName;
  late String photoUrl;

  PostAuthor({required this.displayName, required this.photoUrl});

  PostAuthor.fromMap({required Map<String, dynamic> json}) {
    displayName = json['displayName'];
    photoUrl = json['photoUrl'];
  }
}
