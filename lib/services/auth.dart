// Classe criada para gerenciar os tipos de autenticação

import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  // cria um objeto que conversa com o firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // creia um usuario baseado no login do farebase
  User _userFirebaseUser(FirebaseUser user)
  {
    return user != null ? User(uid: user.uid) : null;
  }

  // Autenticação muda o fluxo do usuario
  Stream<User> get user
  {
    return _auth.onAuthStateChanged
      .map(_userFirebaseUser);
  }

  // sign in Anon
  Future aignInAnon() async
  {
    try
    {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      return _userFirebaseUser(user);
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  // sign in Email/Senha

  //sign Out
}