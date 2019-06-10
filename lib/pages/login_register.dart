import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ulivemedia/services/auth_service.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  UserRepository user = UserRepository.instance();
  AuthMode _authMode = AuthMode.Login;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'country': null,
    'name': null,
    'photoUrl': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

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
            child: _authMode == AuthMode.Login
                ? FlatButton(
                    onPressed: () {
                      setState(() {
                        _authMode = AuthMode.Signup;
                      });
                    },
                    child: Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(
                          color: color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : FlatButton(
                    onPressed: () {
                      setState(() {
                        _authMode = AuthMode.Login;
                      });
                    },
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                          color: color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          )
        ],
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                            _authMode == AuthMode.Login
                                ? "Sign In"
                                : "Create Account",
                            style: TextStyle(
                                color: color,
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              _authMode == AuthMode.Login
                                  ? Column(children: <Widget>[
                                      _buildEmailTextField(color),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      _buildPasswordTextField(color),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      _buildLoginButton(color)
                                    ])
                                  : Column(children: <Widget>[
                                      _buildNameTextField(color),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      _buildEmailTextField(color),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      _buildPasswordTextField(color),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      _buildPasswordConfirmTextField(color),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      _buildRegisterButton(color),
                                    ]),
                              SizedBox(
                                height: 10.0,
                              ),
                              _buildLoginWithGoogle(),
                              
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              }),
      ),
    );
  }

  Widget _buildEmailTextField(Color color) {
    return Theme(
      data: ThemeData(
          primaryColor: color, primaryColorDark: color, hintColor: color),
      child: TextFormField(
        style: TextStyle(
            color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: "Email",
          hintStyle: TextStyle(
              color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(color: color),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.none,
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
            return 'Please enter a valid email';
          }
        },
        controller: _emailController,
        onSaved: (String value) {
          _formData['email'] = value;
        },
      ),
    );
  }

  Widget _buildPasswordTextField(Color color) {
    return Theme(
      data: ThemeData(
          primaryColor: color, primaryColorDark: color, hintColor: color),
      child: TextFormField(
        style: TextStyle(
            color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle(
              color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(color: color),
          ),
        ),
        controller: _passwordTextController,
        obscureText: true,
        validator: (String value) {
          if (value.isEmpty || value.length < 6) {
            return 'Password invalid';
          }
        },
        onSaved: (String value) {
          _formData['password'] = value;
        },
      ),
    );
  }

  Widget _buildPasswordConfirmTextField(Color color) {
    return Theme(
      data: ThemeData(
          primaryColor: color, primaryColorDark: color, hintColor: color),
      child: TextFormField(
        style: TextStyle(
            color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: "Confirm Password",
          hintStyle: TextStyle(
              color: color, fontSize: 25.0, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            borderSide: new BorderSide(color: color),
          ),
        ),
        obscureText: true,
        validator: (String value) {
          if (_passwordTextController.text != value) {
            return 'Passwords do not match.';
          }
        },
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

  Widget _buildLoginButton(Color color) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: color,
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }

        user.signIn(_emailController.text.trim(), _passwordTextController.text);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.arrowRight,
            color: Colors.white,
          ),
          SizedBox(
            width: 25.0,
          ),
          Text(
            "Sign In",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(Color color) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: color,
      onPressed: () {
        if (!_formKey.currentState.validate()) {
          return;
        }

        user.register(_emailController.text.trim(), _nameController.text,
            _passwordTextController.text);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.arrowRight,
            color: Colors.white,
          ),
          SizedBox(
            width: 25.0,
          ),
          Text(
            "Create Account",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginWithGoogle() {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      color: Colors.redAccent,
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        user.googleSignIn();
        Future.delayed(
            const Duration(milliseconds: 3000), () => Navigator.pop(context));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.google,
            color: Colors.white,
          ),
          SizedBox(
            width: 25.0,
          ),
          Text(
            "Login with Google",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  
}
