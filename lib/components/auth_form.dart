import 'package:chat/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formData = AuthFormData();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_formData.isSignup)
                  TextFormField(
                    key: ValueKey('email'),
                    initialValue: _formData.name,
                    onChanged: (name) => _formData.name = name,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (_name) {
                      final name = _name ?? '';
                      if (name.trim().length < 5) {
                        return 'Name must be at least 5 characters';
                      }

                      return null;
                    },
                  ),
                TextFormField(
                  key: ValueKey('name'),
                  initialValue: _formData.email,
                  onChanged: (email) => _formData.email = email,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  validator: (_email) {
                    final email = _email ?? '';
                    if (!email.contains('@')) {
                      return 'Email is not a valid';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  key: ValueKey('password'),
                  initialValue: _formData.password,
                  onChanged: (password) => _formData.password = password,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_formData.isLogin ? 'Login' : 'Register'),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _formData.toggleAuthMode();
                      });
                    },
                    child: Text(_formData.isLogin
                        ? 'Create a new account?'
                        : 'Already have an account?')),
              ],
            ),
          ),
        ));
  }
}
