
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLogin = true;

  void submit()
  {
    var valid = _formKey.currentState!.validate();

    if(valid)
    {
      print(_emailAddressController.text);
      print(_passwordController.text);
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  right: 20,
                  left: 20,
                  bottom: 30,
                ),
                child: Image.asset('assets/images/chat.PNG',fit: BoxFit.fitHeight),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailAddressController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(Icons.email_rounded,),
                            ),
                            onFieldSubmitted: (_)
                            {
                              submit();
                            },
                            validator: (value)
                            {
                              if (value == null || value.isEmpty || value.trim().isEmpty || !value.contains('@')) {
                                return 'Please enter an valid email address';
                              }
                              return null;
                            },
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_rounded,),
                            ),
                            onFieldSubmitted: (_)
                            {
                              submit();
                            },
                            validator: (value)
                            {
                              if (value == null || value.trim().isEmpty)
                              {
                                return 'Please enter your password';
                              }
                              else if (value.length < 6)
                              {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                          const SizedBox(height: 12.0),
                          ElevatedButton(
                              onPressed: submit,
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                             ),
                              child: Text(_isLogin ? 'Login' : 'Sign up'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? 'Create an account'
                                : 'I already have an account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
