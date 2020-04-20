import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget 
{
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> 
{
  final _formKey = GlobalKey<FormState>();
  final List<String> sugar = ['0', '1', '2', '3', '4'];

  // form values
  String _currentName;
  String _currentSugar;
  int    _currentStrength;

  @override
  Widget build(BuildContext context) 
  {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>
    (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) 
      {
        if(snapshot.hasData)
        {
          UserData userData = snapshot.data;
        

        return Form
        (
          key: _formKey,
          child: Column
          (
            children: <Widget>
            [
              Text
              (
                'Update your brew preferences',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              TextFormField
              (
                initialValue: userData.name,
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'Please Enter your Name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              SizedBox(height: 20.0),

              //dropDown
              DropdownButtonFormField
              (
                decoration: textInputDecoration,
                value: _currentSugar ?? userData.sugar,
                items: sugar.map((sugares)
                {
                  return DropdownMenuItem
                  (
                    value: sugares,
                    child: Text('$sugares sugars'),
                  );
                }).toList(), 
                onChanged: (val) => setState(() => _currentSugar = val),
              ),
              //Slider
              Slider
              (
                value: (_currentStrength ?? userData.strength).toDouble(),
                activeColor: Colors.brown[_currentStrength ?? userData.strength],
                inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                min: 100.0,
                max: 900.0,
                divisions: 8,
                onChanged: (val) => setState(() => _currentStrength = val.round()),
              ),

              RaisedButton
              (
                color: Colors.pink,
                child: Text
                (
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async
                {
                  if(_formKey.currentState.validate())
                  {
                    await DatabaseService(uid: user.uid).updateUserData
                    (
                      _currentSugar ?? userData.sugar,
                      _currentName ?? userData.name, 
                      _currentStrength ?? userData.strength,
                    );
                    Navigator.pop(context);
                  }
                },
                
              )
            ],
          ), 
        );
        }
        else
        {
          return Loading();
        }
      }
    );
  }
}