import 'package:firebase_auth/firebase_auth.dart';

import 'package:oauth2_client/github_oauth2_client.dart';

import 'package:oauth2_client/oauth2_helper.dart';

class Oauth2ClientExample {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<bool> signInWithGithub(
  //     {required String email, required String password}) async {
  //   try {
  //     await _auth.signInWithProvider(GithubAuthProvider());
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<void> fetchFiles() async {
  //   try {
  //     var hlp = OAuth2Helper(
  //       GitHubOAuth2Client(
  //           redirectUri: 'my.test.app://oauth2redirect',
  //           customUriScheme: 'my.test.app'),
  //       grantType: OAuth2Helper.authorizationCode,
  //       clientId: 'XXX-XXX-XXX',
  //       clientSecret: 'XXX-XXX-XXX',
  //       scopes: ['https://www.googleapis.com/auth/drive.readonly'],
  //     );

  //     var resp = await hlp.get('https://www.googleapis.com/drive/v3/files');

  //     print(resp.body);
  //   } catch (e) {
  //     var title = '';
  //     print('ERROR EN: $e');
  //   }
  // }
}

class GithubAuthentication {
  // OAuth2Client ghClient = GitHubOAuth2Client(
  //     redirectUri: 'my.test.app://oauth2redirect',
  //     customUriScheme: 'my.test.app');

  // Future<void> fetchFiles() async {
  //   var hlp = OAuth2Helper(
  //     GoogleOAuth2Client(
  //         redirectUri: 'com.teranet.app:/oauth2redirect',
  //         customUriScheme: 'com.teranet.app'),
  //     grantType: OAuth2Helper.authorizationCode,
  //     clientId: 'XXX-XXX-XXX',
  //     clientSecret: 'XXX-XXX-XXX',
  //     scopes: ['https://www.googleapis.com/auth/drive.readonly'],
  //   );

  //   var resp = await hlp.get('https://www.googleapis.com/drive/v3/files');

  //   print(resp.body);
  // }

  Future<bool> getSomething() async {
    try {
      var githubProvider = GithubAuthProvider();
      githubProvider
          .addScope('https://my-project.firebaseapp.com/__/auth/handler');
      githubProvider.setCustomParameters({
        'allow_signup': 'false',
      });

      var newAuth = await FirebaseAuth.instance
          .signInWithProvider(githubProvider)
          .then((value) {
        print('Credenciales1: ${value.additionalUserInfo}');
        print('Credenciales2: ${value.user}');
        print('Credenciales3: ${value.toString()}');
        print('Credenciales4: ${value.credential}');
        print('Credenciales: ${value.hashCode}');
      });
      print('Aqui va el NEW AUTH $newAuth');
      print(newAuth.hashCode);
      //print(newAuth.whenComplete(() => print('Hey')));
      return true;
    } catch (e) {
      print('GITHUB ERROR EN $e');
      return false;
    }
//   String accessToken = 'das'; // From 3rd party provider
// var githubAuthCredential = GithubAuthProvider.credential(accessToken);
//   FirebaseAuth.instance.signInWithCredential(githubAuthCredential)
//   .then(...);
//If authenticating with GitHub via a 3rd party, use the returned accessToken to sign-in or link the user with the created credential, for example:
  }
//https://github.com/login/oauth/authorize?client_id=be037aac6acab0d672b4&scope=public_repo%20read:user%20user:email
//https://github.com/login/oauth/authorize
  //OAuthProvider provedor = OAuthProvider('github.com');

  // Future<UserCredential> signInWithGithub() async {
  //   // Create a GitHubSignIn instance
  //   final GitHubSignIn gitHubSignIn = GitHubSignIn(
  //       clientId: 'client',
  //       clientSecret: 'ckient',
  //       redirectUrl: 'https://my-project.firebaseapp.com/__/auth/handler');

}
