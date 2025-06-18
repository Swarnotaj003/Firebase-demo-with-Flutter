import 'package:firebase_demo/screens/login_page.dart';
import 'package:firebase_demo/services/auth_service.dart';
import 'package:firebase_demo/widgets/my_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // service class for authentication
  AuthService auth = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              // lottie animation
              SizedBox(
                height: 300,
                child: Lottie.network(
                  'https://lottie.host/465251be-508f-4f50-ba72-03378ce68e35/iTUMJMGb8j.json',
                ),
              ),
                
              SizedBox(height: 20),
              // Some Text
              Text(
                'Register Now!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
                
              SizedBox(height: 10),
              // Email field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
              ),
                
              SizedBox(height: 10),
              // Password field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),
                
              SizedBox(height: 10),
              // Confirm Password field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                      ),
                    ),
                  ),
                ),
              ),
                
              SizedBox(height: 20),
              // Signin BTN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () async {
                    var valEmailId = _emailController.text;
                    var valPassword = _passwordController.text;
                    var valConfirmPassword = _confirmPasswordController.text;

                    // Validation
                    if (valEmailId.isEmpty) {
                      showMySnackBar(context, 'Please fill your email ID!', Colors.red);
                    }
                    else if (valPassword.length < 6) {
                      showMySnackBar(context, 'Password must contain atleast 6 characters!', Colors.red);
                    }
                    else if (valConfirmPassword.isEmpty) {
                      showMySnackBar(context, 'Please confirm your password!', Colors.red);
                    } else if (_passwordController.text != _confirmPasswordController.text) {
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Sign up Error!'),
                            content: Text('Passwords don\'t match! Please try again.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context), 
                                child: Text('Ok'),
                              ),
                            ],
                          );
                        }
                      );
                    }
                    else {
                      try {
                        await auth.signUp(_emailController.text.trim(), _passwordController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      } catch (e) {
                        showMySnackBar(
                          context,
                          "Invalid email or login if already registered!",
                          Colors.red,
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
                
              // Login
              SizedBox(height: 10),
              Text('Already a member?', textAlign: TextAlign.left,),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
