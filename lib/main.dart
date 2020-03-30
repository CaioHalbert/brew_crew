import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Main é o ponto de inicio da aplicação, sempre que aberta, esse é o arquivo que é chamado
void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{

  @override
  Widget build(BuildContext context) 
  {
    return StreamProvider<User>.value
    (
      value: AuthService().user,
      child: MaterialApp(
          // indicamos o caminho da pagina principal ao abrir o app
        home: Wrapper(),
      ),
    );
  }
}
