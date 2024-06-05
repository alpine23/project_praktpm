import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/user.dart';
import '../services/db_service.dart';
import '../services/session_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _currentUser;
  final DBService _databaseHelper = DBService();
  final SessionService _sessionService = SessionService();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final username = await _sessionService.getSession();
    if (username != null) {
      final user = await _databaseHelper.getUser(username);
      setState(() {
        _currentUser = user;
        _passwordController.text = user?.password ?? '';
      });
    }
  }

  Future<void> _updateProfilePicture(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final user = _currentUser;
      if (user != null) {
        user.profilePicture = pickedFile.path;
        await _databaseHelper.updateUser(user);
        setState(() {
          _currentUser = user;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile picture updated successfully')),
        );
      }
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Photo Library'),
                  onTap: () {
                    _updateProfilePicture(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    _updateProfilePicture(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: _currentUser == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: ClipOval(
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: _currentUser!.profilePicture == null
                                  ? AssetImage(
                                      'assets/images/default_profile.png')
                                  : FileImage(
                                          File(_currentUser!.profilePicture!))
                                      as ImageProvider<Object>,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _showPicker(context);
                      },
                      child: Text('Update Profile Picture'),
                    ),
                    SizedBox(height: 20),
                    _buildProfileDetail(
                      label: 'Name',
                      value: _currentUser!.name ?? '',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 20),
                    _buildProfileDetail(
                      label: 'Email',
                      value: _currentUser!.email,
                      icon: Icons.email,
                    ),
                    SizedBox(height: 20),
                    _buildProfileDetail(
                      label: 'Encrypted Password',
                      value: _passwordController.text,
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProfileDetail({
    required String label,
    required String value,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(143, 148, 251, 1),
          ),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(icon, color: Color.fromRGBO(143, 148, 251, 1)),
            SizedBox(width: 10),
            Expanded(
              child: isPassword
                  ? Row(
                      children: [
                        Expanded(
                          child: Text(
                            _isPasswordVisible ? value : '••••••••',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color.fromRGBO(143, 148, 251, 1),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ],
                    )
                  : Text(
                      value,
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
