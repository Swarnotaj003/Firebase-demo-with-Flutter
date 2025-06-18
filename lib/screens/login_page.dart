import 'package:firebase_demo/screens/register_page.dart';
import 'package:firebase_demo/screens/view_item.dart';
import 'package:firebase_demo/services/auth_service.dart';
import 'package:firebase_demo/widgets/my_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // service class for authentication
  AuthService auth = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
              Text(
                'Login to your Account',
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
        
              // Log-in Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () async {
                    var valEmailId = _emailController.text;
                    var valPassword = _passwordController.text;

                    // Validation
                    if (valEmailId.isEmpty) {
                      showMySnackBar(context, 'Please fill your email ID!', Colors.red);
                    }
                    else if (valPassword.length < 6) {
                      showMySnackBar(context, 'Password must contain atleast 6 characters!', Colors.red);
                    }
                    else {
                      try {
                        await auth.logIn(_emailController.text.trim(), _passwordController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ViewItem()),
                        );
                      } catch (e) {
                        showMySnackBar(
                        context,
                        "Invalid email or password! Register if you don't have an account!",
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
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        
              // Register
              SizedBox(height: 10),
              Text('Don\'t have an account?', textAlign: TextAlign.left,),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => RegisterPage(),
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
                        'Register',
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