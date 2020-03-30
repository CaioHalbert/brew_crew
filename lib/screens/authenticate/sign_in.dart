// Pagina de login

import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget 
{
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> 
{
  // gravo o serviço em uma variavel para acessar a classe de autenticação
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.brown[100],
      appBar: AppBar
      (
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew'),
      ),
      body: Container
      (
        child: Padding
        (
          padding: EdgeInsets.symmetric
          (
            vertical: 25,
            horizontal: 15,
          ),
          child: RaisedButton
          (
            child: Text('Sign In Anon'),
            onPressed: () 
              async
              {
                dynamic result = await _auth.aignInAnon();
                if (result == null)
                {
                  print('error signIn');
                }else
                {
                  print('signed In');
                  print(result.uid);
                }
              },
          ),
        ),
      ),
    );
  }
}