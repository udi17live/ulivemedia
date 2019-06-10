import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ulivemedia/services/auth_service.dart';

class EditProfilePage extends StatefulWidget {
  final FirebaseUser user;
  EditProfilePage(this.user);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'country': null,
    'name': null,
    'photoUrl': null,
  };
  File _imageFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  //UserRepository userRepository;
  //FirebaseUser userCurrent;

  

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.times, size: 25, color: color),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.save,
                        color: color,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "Save",
                        style: TextStyle(
                            color: color,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            Text("Edit Profile",
                style: TextStyle(
                    color: color, fontSize: 30.0, fontWeight: FontWeight.bold)),

            _buildCircleAvatar(widget.user),

            
                        
          ],
        ),
      ),
    );
  }

  

  Widget _buildNameTextField(Color color) {
    return Theme(
      data: ThemeData(
          primaryColor: color, primaryColorDark: color, hintColor: color),
      child: TextFormField(
        style: TextStyle(
            color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: "Name",
          hintStyle: TextStyle(
              color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(color: color),
          ),
        ),
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        validator: (String value) {
          if (value.trim().isEmpty) {
            return 'Please enter your name';
          }
        },
        controller: _nameController,
        onSaved: (String value) {
          _formData['name'] = value;
        },
      ),
    );
  }

 /*  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'Pick an Image',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Use Camera'),
                onPressed: () {
                  _getImage(context, ImageSource.camera);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Use Gallery'),
                onPressed: () {
                  _getImage(context, ImageSource.gallery);
                },
              )
            ]),
          );
        });
  } */

  /* Widget _buildImagePicker(){
    final buttonColor = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(
            color: buttonColor,
            width: 2.0,
          ),
          onPressed: () {
            _openImagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: buttonColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Add Image',
                style: TextStyle(color: buttonColor),
              )
            ],
          ),
        ),
        SizedBox(height: 10.0),
        _imageFile == null
            ? Text('Please pick an image.')
            : Image.file(
                _imageFile,
                fit: BoxFit.cover,
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
              )
      ],
    );
  } */

  Widget _buildCircleAvatar(FirebaseUser user) {
    String photourl =
        'https://firebasestorage.googleapis.com/v0/b/ulivemedia-8a6ec.appspot.com/o/user_default.png?alt=media&token=4ed7fb78-416c-420a-9238-328666fb8e37';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: user.photoUrl != null ? NetworkImage(user.photoUrl):NetworkImage(photourl),
                fit: BoxFit.cover)),
      ),
    );
  }
}
