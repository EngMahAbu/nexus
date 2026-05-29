import 'package:intl/intl.dart';
import 'package:nexus/models/post_author.dart';

class Post {
  // Cloud fields
  late String authorUid;
  late String textContent;
  late List<dynamic> imagesUrls;
  late List<dynamic> likesList;
  late List<dynamic> commentsList;
  late int sharesCounter;
  late String createdAt;

  // Local Fields
  late String uid;
  late PostAuthor postAuthor;
  bool isLiked = false;

  Post({
    required this.uid,
    required this.authorUid,
    required this.postAuthor,
    required this.textContent,
    required this.imagesUrls,
    required this.likesList,
    required this.isLiked,
    required this.commentsList,
    required this.sharesCounter,
    required this.createdAt,
  });

  // Initial object for publishing
  Post.create({required this.authorUid, required this.textContent}) {
    // postAuthor = null
    imagesUrls = [];
    likesList = [];
    commentsList = [];
    sharesCounter = 0;
    createdAt = DateFormat('d MMMM yyyy hh:mm a').format(DateTime.now());
  }

  Post.fromMap(Map<String, dynamic> postMap) {
    authorUid = postMap['authorUid'];
    textContent = postMap['textContent'];
    imagesUrls = postMap['imagesUrls'];
    likesList = postMap['likesList'];
    commentsList = postMap['commentsList'];
    sharesCounter = postMap['sharesCounter'];
    createdAt = postMap['createdAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'authorUid': authorUid,
      'textContent': textContent,
      'imagesUrls': imagesUrls,
      'likesList': likesList,
      'commentsList': commentsList,
      'sharesCounter': sharesCounter,
      'createdAt': createdAt,
    };
  }
}
