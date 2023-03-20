class GetUsersModel {
  final int? id, verified;
  final String? name, username, profilePictore;

  GetUsersModel({
    this.id,
    this.verified,
    this.name,
    this.profilePictore,
    this.username,
  });

  factory GetUsersModel.fromJson(Map<String, dynamic> json) => GetUsersModel(
        id: json["id"],
        verified: json["verified"],
        name: json["name"],
        username: json["username"],
        profilePictore: json["profile_picture"],
      );
}
