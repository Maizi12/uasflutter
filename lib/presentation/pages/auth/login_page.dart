import 'package:digit/presentation/cubits/auth/auth_cubit.dart';
import 'package:digit/presentation/pages/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: () {
            // Navigate to home screen
            Navigator.pushReplacementNamed(context, 'dashboard');
          },
          failed: (message) {
            // Show snackbar error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      },
      child: _LoginPageView(),
    );
  }

  Widget _LoginPageView() {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                _buildHeader(),
                const SizedBox(height: 48),
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildPasswordField(),
                const SizedBox(height: 16),
                _buildForgotPassword(),
                const SizedBox(height: 32),
                _buildLoginButton(),
                const SizedBox(height: 16),
                _buildSignUpButton(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Login',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xff240e50),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      height: 61,
      width: 335,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: const Color.fromARGB(255, 143, 148, 163),
          width: 2.0,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'Email',
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(15, 2, 0, 0),
        ),
        cursorRadius: Radius.circular(24),
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value?.isEmpty ?? true) return 'Email is required';
          if (!value!.contains('@')) return 'Invalid email';
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      width: 335,
      height: 59,
      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
      decoration: BoxDecoration(
        // background: #FFFFFF;
        border: Border.all(
          color: const Color.fromARGB(255, 143, 148, 163),
          width: 2.0,
        ),
        // border-radius: 24px;
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: _obscurePassword,
        style: const TextStyle(
          // font-family: 'Inter'; (using default)
          fontWeight: FontWeight.w500,
          fontSize: 14,
          // letterSpacing: -0.4,
          color: Color(0xFF040C22),
        ),
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(),
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(15, 2, 0, 0),
          isDense: true,
          suffixIcon: IconButton(
            iconSize: 24,
            onPressed: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off),
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) return 'Password is required';
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading =
            state.maybeWhen(loading: () => true, orElse: () => false);

        return ElevatedButton(
          onPressed: () async {
            isLoading ? LoadingScreen() : _handleLogin();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff2c14dd),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: isLoading
              ? LoadingScreen()
              : const Text('Login', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<AuthCubit>().login(
          _emailController.text.trim(),
          _passwordController.text,
        );
  }

  // Other widget methods...
  Widget _buildForgotPassword() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading =
            state.maybeWhen(loading: () => true, orElse: () => false);

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            isLoading ? LoadingScreen() : _handleForgotPassword;
          },
          child: isLoading
              ? const LoadingScreen()
              : Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 1, 0),
                  child: const Text(
                    'Forgot Password?',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.2125,
                      color: Color(0xff2c14dd),
                    ),
                  ),
                ),
        );
      },
    );
  }

  void _handleForgotPassword() {
    // TODO: Implement forgot password logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot Password'),
        content: const Text('Feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading =
            state.maybeWhen(loading: () => true, orElse: () => false);

        return ElevatedButton(
          onPressed: () async {
            isLoading ? LoadingScreen() : _handleSignUp();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff2c14dd),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: isLoading
              ? const LoadingScreen()
              : const Text('SignUp', style: TextStyle(color: Colors.white)),
        );
      },
    );
  }

  void _handleSignUp() {
    if (!_formKey.currentState!.validate()) return;
    // TODO: Navigate to sign up page
    context.go('/register');
  }
}
