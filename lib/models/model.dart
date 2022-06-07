class UserModel {
  String? name;
  String? role;
  String? uid;

// receiving data
  UserModel({this.uid, this.name, this.role});
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      role: map['role'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'role': role,
    };
  }
}