import 'package:flutter/material.dart';

import '../component/votix_text.dart';
import '../utils/constants/app_color.dart';
import '../utils/validators/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _submitLogin() {
    FocusScope.of(context).unfocus(); // Close keyboard

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() => _isLoading = false);
        Navigator.pushNamed(context, '/dashboard');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading:true ,

      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              VotixText.title('Welcome to Votix 👋'),
              const SizedBox(height: 24),
              SizedBox(width: 15,
                child: Image.asset(
                  'assets/image/ticket.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 26),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: VotixColors. primaryPurple ,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    'Login',
                    style: TextStyle(fontSize: 16,
                      color: Colors.white,

                    ),


                  ),
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/image/login.png',
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              )
            ],
          ),
        ),
      ),
    );
  }
}