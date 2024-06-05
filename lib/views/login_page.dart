import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../services/db_service.dart';
import '../services/encryption_service.dart';
import '../services/session_service.dart';
import 'main_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DBService _dbService = DBService();
  final EncryptionService _encryptionService = EncryptionService();
  final SessionService _sessionService = SessionService();

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
                  _buildLoginForm(context),
                  SizedBox(height: 30),
                  _buildLoginButton(context),
                  SizedBox(height: 70),
                  _buildRegisterOption(context),
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
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            width: 80,
            height: 200,
            child: FadeInUp(
              duration: Duration(seconds: 1),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-1.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 140,
            width: 80,
            height: 150,
            child: FadeInUp(
              duration: Duration(milliseconds: 1200),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-2.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 40,
            top: 40,
            width: 80,
            height: 150,
            child: FadeInUp(
              duration: Duration(milliseconds: 1300),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clock.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: FadeInUp(
              duration: Duration(milliseconds: 1600),
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    "Nopliss Login",
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

  Widget _buildLoginForm(BuildContext context) {
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

  Widget _buildLoginButton(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 1900),
      child: GestureDetector(
        onTap: () async {
          await _handleLogin(context);
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
              "Login",
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

  Widget _buildRegisterOption(BuildContext context) {
    return Column(
      children: [
        FadeInUp(
          duration: Duration(milliseconds: 1600),
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(
              child: Text(
                "Don't have an account?",
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
                  builder: (context) => RegisterPage(),
                ),
              );
            },
            child: Text(
              "Register",
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

  Future<void> _handleLogin(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final encryptedPassword = await _encryptionService.encrypt(password);
    final user = await _dbService.getUser(username);

    if (user != null && user.password == encryptedPassword.toString()) {
      await _sessionService.saveSession(username);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Username or password is incorrect',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
      );
    }
  }
}
