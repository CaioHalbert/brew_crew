// Classe criada para gerenciar os tipos de autenticação

import 'package:firebase_auth/firebase_auth.dart';

class AuthService
{
  // cria um objeto que conversa com o firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in Anon
  Future aignInAnon() async
  {
    try
    {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;

      return user;
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }

  // sign in Email/Senha

  //sign Out
}