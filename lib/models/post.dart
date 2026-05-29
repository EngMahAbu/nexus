class Post {
  late String authorUid;
  late String textContent;
  late List<dynamic>? imagesUrls;
  late List<dynamic>? reactionsList;
  late List<dynamic>? commentsList;
  late int sharesCounter;

  Post({
    required this.authorUid,
    required this.textContent,
    required this.imagesUrls,
    required this.reactionsList,
    required this.commentsList,
    required this.sharesCounter,
  });

  Post.create({required this.authorUid, required this.textContent}) {
    imagesUrls = [];
    reactionsList = [];
    commentsList = [];
    sharesCounter = 0;
  }

  Post.fromMap(Map<String, dynamic> postMap) {
    authorUid = postMap['authorUid'];
    textContent = postMap['textContent'];
    imagesUrls = postMap['imagesUrls'];
    reactionsList = postMap['reactionsList'];
    commentsList = postMap['commentsList'];
    sharesCounter = postMap['sharesCounter'];
  }

  Map<String, dynamic> toMap() {
    return {
      'authorUid': authorUid,
      'textContent': textContent,
      'imagesUrls': imagesUrls,
      'reactionsList': reactionsList,
      'commentsList': commentsList,
      'sharesCounter': sharesCounter,
    };
  }
}
