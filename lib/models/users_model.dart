// int? idUser=1;
//   String? imageUser='assets/ProfilePicture.png';
//   String? nameUser = 'Luis Martinez';
//   String? emailUser = 'luismartinez@gmail.com';
//   String? phoneUser '54121231231';
//   String? githubUser 'luismartinez@gmail.com';

class UsersDAO {
  int? idUser;
  String? imageUser;
  String? nameUser;
  String? emailUser;
  String? phoneUser;
  String? githubUser;

  UsersDAO(
      {this.idUser,
      this.imageUser,
      this.nameUser,
      this.emailUser,
      this.phoneUser,
      this.githubUser});

  factory UsersDAO.fromJSON(Map<String, dynamic> mapUser) {
    return UsersDAO(
      idUser: mapUser['idUser'],
      imageUser: mapUser['imageUser'],
      nameUser: mapUser['nameUser'],
      emailUser: mapUser['emailUser'],
      phoneUser: mapUser['phoneUser'],
      githubUser: mapUser['githubUser'],
    );
  }
}
