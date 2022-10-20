import 'package:chat/components/auth_form.dart';
import 'package:chat/models/auth_form_data.dart';
import 'package:chat/services/auth/auth_service_mock.dart';
import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData data) async {
    try {
      setState(() => _isLoading = true);

      if (data.isLogin) {
        await AuthServiceMock().login(data.email, data.password);
      } else {
        await AuthServiceMock()
            .signup(data.name, data.email, data.password, data.image);
      }
    } catch (error) {
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(
                onSubmit: _handleSubmit,
              ),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
