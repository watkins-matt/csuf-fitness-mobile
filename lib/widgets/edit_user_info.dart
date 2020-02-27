import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_info.dart';


class EditUserInfo extends StatefulWidget {
  
  EditUserInfo({Key key}) : super(key: key);

  @override
  _EditUserInfo createState() => _EditUserInfo();
}

class _EditUserInfo extends State<EditUserInfo> {
  
  final _formKey = GlobalKey<FormState>();

  get firstname => null;

  get lastname => null;

  get age => null;

  get height => null;

  get weight => null;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your first name',
            ),
            
            controller: firstname,
            validator: (firstname) {
              if (firstname.isEmpty) {
                return 'Please enter a valid name';
              }
              return null;
            },
            
            ),
            
            TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your last name',
            ),
            controller: lastname,
            validator: (lastname) {
              if (lastname.isEmpty) {
                return 'Please enter a valid name';
              }
              return null;
            },
            ),
            
            TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your age',
            ),
            controller: age,
            validator: (age) {
              if (age.isEmpty && age is int) {
                return 'Please enter a valid age';
              }
              return null;
            },
            ),
            
            TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your height in inches',
            ),
            controller: height,
            validator: (height) {
              if (height.isEmpty && height is int) {
                return 'Please enter a valid height';
              }
              return null;
            },
            ),
             
             TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your weight in pounds',
            ),
            controller: weight,
            validator: (weight) {
              if (weight.isEmpty && weight is int) {
                return 'Please enter a valid weight';
              }
              return null;
            },
            ),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                }
                setUserInfo();
              },
              child: Text('Submit'),
            ),
          ),
          ],
        ),
    );
  }
  void setUserInfo(){
    UserInfo(firstname, lastname, age, height, weight);
  }
}