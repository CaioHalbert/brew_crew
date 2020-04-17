import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

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
            decoration: textInputDecoration,
            validator: (val) => val.isEmpty ? 'Please Enter your Name' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 20.0),

          //dropDown
          DropdownButtonFormField
          (
            decoration: textInputDecoration,
            value: _currentSugar ?? '0',
            items: sugar.map((sugars)
            {
              return DropdownMenuItem
              (
                value: sugars,
                child: Text('$sugars sugar'),
              );
            }).toList(), 
            onChanged: (val) => setState(() => _currentSugar = val),
          ),
          //Slider
          Slider
          (
            value: (_currentStrength ?? 100).toDouble(),
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.brown[_currentStrength ?? 100],
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
              print(_currentName);
              print(_currentSugar);
              print(_currentStrength);
            },
            
          )
        ],
      ), 
    );
  }
}