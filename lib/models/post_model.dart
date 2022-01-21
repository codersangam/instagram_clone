class PostModel {
  String? postId;
  String? postDescription;
  String? postUrl;
  List? postLikes;
  DateTime? postDate;
  String? uid;
  String? userName;
  String? profileImage;

  PostModel(
      {this.postId,
      this.postDescription,
      this.postUrl,
      this.postLikes,
      this.postDate,
      this.uid,
      this.userName,
      this.profileImage});

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "postDescription": postDescription,
        "postUrl": postUrl,
        "postLikes": postLikes,
        "postDate": postDate,
        "uid": uid,
        "userName": userName,
        "profileImage": profileImage,
      };
}
