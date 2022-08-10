import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  //final String email;
  final String uid;
  final String userName;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post(
      {required this.description,
      // required this.email,
      required this.uid,
      required this.userName,
      required this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      required this.likes});

  Map<String, dynamic> toJson() => {
        'description': description,
        "userName": userName,
        "uid": uid,
        'postId': postId,
        'datePublished': datePublished,
        'postUrl': postUrl,
        // "email":email,
        'profImage': profImage,
        'likes': likes
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      userName: snapshot['userName'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
      postUrl: snapshot['postUrl'],
      datePublished:snapshot['datePublished'] ,
      postId: snapshot['postId'],
    );
  }
}
