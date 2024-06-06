import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../services/db_service.dart';
import '../services/encryption_service.dart';
import '../models/user.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final DBService _dbService = DBService();
  final EncryptionService _encryptionService = EncryptionService();

  bool _isEmailValid(String email) {
    String pattern = r'^[^@]+@[^@]+\.[^@]+$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  _buildRegistrationForm(),
                  SizedBox(height: 30),
                  _buildRegisterButton(context),
                  SizedBox(height: 70),
                  _buildLoginOption(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: FadeInUp(
              duration: Duration(milliseconds: 1600),
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return FadeInUp(
      duration: Duration(milliseconds: 1800),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color.fromRGBO(143, 148, 251, 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(143, 148, 251, .2),
              blurRadius: 20.0,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                ),
              ),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Name",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Montserrat',
                  ),
                ),
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                ),
              ),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Montserrat',
                  ),
                ),
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                ),
              ),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Username",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Montserrat',
                  ),
                ),
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Montserrat',
                  ),
                ),
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 1900),
      child: GestureDetector(
        onTap: () async {
          await _handleRegister(context);
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ],
            ),
          ),
          child: Center(
            child: Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginOption(BuildContext context) {
    return Column(
      children: [
        FadeInUp(
          duration: Duration(milliseconds: 1600),
          child: Container(
            margin: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                "Already have an account?",
                style: TextStyle(
                  color: Color.fromARGB(255, 119, 119, 119),
                  fontSize: 15,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ),
        FadeInUp(
          duration: Duration(milliseconds: 2000),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: Text(
              "Login",
              style: TextStyle(
                color: Color.fromRGBO(143, 148, 251, 1),
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleRegister(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final email = _emailController.text;
    final name = _nameController.text;

    if (username.isNotEmpty &&
        password.isNotEmpty &&
        email.isNotEmpty &&
        name.isNotEmpty) {
      if (_isEmailValid(email)) {
        final encryptedPassword = await _encryptionService.encrypt(password);
        final newUser = User(
          username: username,
          password: encryptedPassword.toString(),
          email: email,
          name: name,
        );

        try {
          await _dbService.insertUser(newUser);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User registered successfully',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
          );
          Navigator.pop(context);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error registering user: $e',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Invalid email format',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'All fields are required',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
      );
    }
  }
}
