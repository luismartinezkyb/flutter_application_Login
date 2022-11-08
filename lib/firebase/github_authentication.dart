import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GithubAuthentication {
  // Future<UserCredential> signInWithGithub() async {
  //   // Create a GitHubSignIn instance
  //   final GitHubSignIn gitHubSignIn = GitHubSignIn(
  //       clientId: 'be037aac6acab0d672b4',
  //       clientSecret: '7972055c1047eb10d0b951eb47913c2940fc321e',
  //       redirectUrl: 'https://my-project.firebaseapp.com/__/auth/handler');

  //   // Trigger the sign-in flow
  //   final result = await gitHubSignIn.signIn(context);

  //   // Create a credential from the access token
  //   final githubAuthCredential = GithubAuthProvider.credential(result.token);

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance
  //       .signInWithCredential(githubAuthCredential);
  // }

  // void onClickGitHubLoginButton() async {
  //   const String url = "https://github.com/login/oauth/authorize" +
  //       "?client_id=" +
  //       'be037aac6acab0d672b4' +
  //       "&scope=public_repo%20read:user%20user:email";

  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: false,
  //       forceWebView: false,
  //     );
  //   } else {
  //     print("CANNOT LAUNCH THIS URL!");
  //   }
  // }
}
