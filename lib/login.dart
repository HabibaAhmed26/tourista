import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourista/core/di/di.dart';
import 'package:tourista/core/models/user_model.dart';
import 'package:tourista/core/utils/app_assets.dart';
import 'package:tourista/core/utils/app_strings.dart';
import 'package:tourista/presentation/features/authentication/cubit/authentication_cubit.dart';
import 'package:tourista/presentation/features/authentication/view/sign_up.dart';
import 'package:tourista/presentation/features/profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  void _loginWithGoogle() {
    print('Login with Google pressed');
  }

  void _navigateToRegister() {
    print('Navigate to register');
  }

  void _loginWithEmail() {
    print('Email login pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Background Image
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.bg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Dark Overlay for better readability
              Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.black.withOpacity(0.4),
              ),

              // Login Content
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 400, // This will now work properly
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(32.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            // App Logo/Name
                            const Text(
                              'Tourista',
                              style: TextStyle(
                                fontSize: 36.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 24.0),

                            // Login Title
                            const Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Welcome back! Sign in to continue',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32.0),

                            // Google Login Button
                            SizedBox(
                              width: double.infinity,
                              height: 56.0,
                              child: ElevatedButton(
                                onPressed: _loginWithGoogle,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black87,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  elevation: 2,
                                  shadowColor: Colors.black.withOpacity(0.1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppAssets.googleLogo,
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Login with Google',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24.0),

                            // Divider with "or" text
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.shade400,
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Text(
                                    'or',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey.shade400,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24.0),

                            // Email & Password Login Form
                            Column(
                              children: [
                                // Email Field
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter your email',
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.grey.shade600,
                                    ),

                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 16.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                // Password Field
                                TextFormField(
                                  obscureText: _obscurePassword,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.grey.shade600,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 16.0,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),

                                // Remember Me Checkbox
                                Row(
                                  children: [
                                    Checkbox(
                                      value: false,
                                      onChanged: (value) {
                                        // Handle remember me
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                    Text(
                                      'Remember me',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        // Forgot password
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: Colors.blue.shade700,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),

                                // Login Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 50.0,
                                  child:
                                      BlocListener<
                                        AuthenticationCubit,
                                        AuthenticationState
                                      >(
                                        listener: (context, state) {
                                          if (state is AuthenticationError) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(state.message),
                                              ),
                                            );
                                            print(state.message);
                                          }
                                          if (state is Authenticationloaded) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Profile(),
                                              ),
                                            );
                                          }
                                        },
                                        child: ElevatedButton(
                                          //onPressed: _login,
                                          onPressed: () async {
                                            await context
                                                .read<AuthenticationCubit>()
                                                .signIn(
                                                  _emailController.text,
                                                  _passwordController.text,
                                                );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                              255,
                                              43,
                                              35,
                                              149,
                                            ),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            elevation: 0,
                                          ),
                                          child: const Text(
                                            'Login',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24.0),

                            // Register Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16.0,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Register here',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
