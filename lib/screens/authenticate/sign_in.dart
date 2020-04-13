// Pagina de login

import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget 
{

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> 
{
  // gravo o serviço em uma variavel para acessar a classe de autenticação
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Variaveis para armazenar email e senha
  String email = '';
  String senha = '';
  String erro  = '';

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
        actions: <Widget>
        [
          FlatButton.icon
          (
            onPressed: () 
            {
              widget.toggleView();
            }, 
            icon: Icon(Icons.person), 
            label: Text("Register")
            )
        ],

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

          child: Form
          (
            key: _formKey,
            child: Column
            (
              children: <Widget>
              [
                SizedBox(height: 20.0,),

                TextFormField
                (
                  validator: (val) => val.length < 6 ? "Enter an passwor 6+ char long" : null,
                  onChanged: (val) 
                  {
                    setState(() => email = val);
                  },
                ),

                SizedBox(height: 20.0,),

                TextFormField
                (
                  validator: (val) => val.length < 6 ? "Enter an passwor 6+ char long" : null,
                  obscureText: true,
                  onChanged: (val) 
                  {
                    setState(() => senha = val);
                  },
                ),

                SizedBox(height: 20.0,),

                RaisedButton
                (
                  color: Colors.pink[400],
                  child: Text("Sign In", style: TextStyle(color: Colors.white),),
                  onPressed: () async
                  {
                    if(_formKey.currentState.validate())
                    {
                      dynamic result = await _auth.signInWithEmailAndPassword(email, senha);
                      if(result == null)
                      {
                        setState(() => erro = "Usuário ou senha não Inválidos");
                      }
                    }
                  },
                ),

                SizedBox(height: 12.0),

                Text
                (
                  erro,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}