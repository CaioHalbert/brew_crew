import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget 
{
  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> 
{

    // gravo o serviço em uma variavel para acessar a classe de autenticação
  final AuthService _auth = AuthService();
  final _formKey          = GlobalKey<FormState>();
  bool loading            = false;

  // Variaveis para armazenar email e senha
  String email = '';
  String senha = '';
  String erro  = '';


  @override
  Widget build(BuildContext context) 
  {
    return loading ? Loading() : Scaffold
    (
      backgroundColor: Colors.brown[100],
      appBar: AppBar
      (
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to Brew Crew'),
        actions: <Widget>
        [
          FlatButton.icon
          (
            onPressed: () 
            {
              widget.toggleView();
            }, 
            icon: Icon(Icons.person), 
            label: Text("SignIn")
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
                  decoration: textInputDecoration.copyWith(hintText: 'E-mail'),
                  validator: (val) => val.isEmpty ? "Enter an E-mail" : null,
                  onChanged: (val) 
                  {
                    setState(() => email = val);
                  },
                ),

                SizedBox(height: 20.0,),

                TextFormField
                (
                  decoration: textInputDecoration.copyWith(hintText: 'Senha'),
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
                  child: Text("Sign Up", style: TextStyle(color: Colors.white),),
                  onPressed: () async
                  {
                    if(_formKey.currentState.validate())
                    {
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, senha);
                      if(result == null)
                      {
                        setState(() => 
                        {
                          erro = "Use um email ou senha válidos",
                          loading = false,
                        });
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