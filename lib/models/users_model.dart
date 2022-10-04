class UserModel {
  late int? idUser = 0;
  late String? nameUser = "";
  late String? emailUser = "";
  late String? phoneUser = "";
  late String? githubUser = "";

  UserModel(int i, String name, String email, String phone, String github) {
    this.nameUser = name;
    this.emailUser = email;
    this.phoneUser = phone;
    this.githubUser = github;
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'idUser': idUser,
      'nameUser': nameUser,
      'emailUser': emailUser,
      'phoneUser': phoneUser,
      'githubUser': githubUser,
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    idUser = map['idUser'];
    nameUser = map['nameUser'];
    emailUser = map['emailUser'];
    phoneUser = map['phoneUser'];
    githubUser = map['githubUser'];
  }
}
