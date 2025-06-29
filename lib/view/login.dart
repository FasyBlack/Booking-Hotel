// import yang dibutuhkan
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fasy_hotel/service/auth_service.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ClipLogin19 extends StatefulWidget {
  const ClipLogin19({Key? key}) : super(key: key);

  @override
  State<ClipLogin19> createState() => _ClipLogin19State();
}

class _ClipLogin19State extends State<ClipLogin19> {
  bool animate = false;

  // Sign In Controllers
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  // Sign Up Controllers
  final signupFirstNameController = TextEditingController();
  final signupLastNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();

  final authService = AuthService();

  @override
  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupFirstNameController.dispose();
    signupLastNameController.dispose();
    signupEmailController.dispose();
    signupPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Image.asset(
                'assets/aston.jpg',
                width: screenSize.width,
                height: screenSize.height,
                fit: BoxFit.cover,
              ),
            ),
            // SIGN IN
            AnimatedPositioned(
              duration: Duration(milliseconds: 700),
              top: animate ? -screenSize.height : 0,
              left: 40,
              child: _buildAuthCard(
                screenSize: screenSize,
                title: "Sign In",
                fields: [
                  _buildTextField("Email", controller: loginEmailController),
                  _buildTextField("Password",
                      controller: loginPasswordController, obscureText: true),
                ],
                bottomWidget: Column(
                  children: [
                    SizedBox(height: 20),
                    _buildButton("Sign In", onTap: () async {
                      try {
                        final result = await authService.login(
                          loginEmailController.text.trim(),
                          loginPasswordController.text.trim(),
                        );
                        loginEmailController.clear();
                        loginPasswordController.clear();

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.bottomSlide,
                          title: 'Login Berhasil',
                          desc: 'Selamat datang!',
                          btnOkOnPress: () => Navigator.pushReplacementNamed(
                              context, '/user_dashboard'),
                        ).show();
                      } catch (e) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.bottomSlide,
                          title: 'Login Gagal',
                          desc: 'Email atau password salah',
                          btnOkOnPress: () {},
                        ).show();
                      }
                    }),
                    SizedBox(height: 10),
                    Text("Don't have an account?",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => setState(() => animate = true),
                      child: Text("Register",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
            // SIGN UP
            AnimatedPositioned(
              duration: Duration(milliseconds: 700),
              top: animate ? 0 : screenSize.height,
              left: 40,
              child: _buildAuthCard(
                screenSize: screenSize,
                title: "Sign Up",
                fields: [
                  _buildTextField("First Name",
                      controller: signupFirstNameController),
                  _buildTextField("Last Name",
                      controller: signupLastNameController),
                  _buildTextField("Email", controller: signupEmailController),
                  _buildTextField("Password",
                      controller: signupPasswordController, obscureText: true),
                ],
                bottomWidget: Column(
                  children: [
                    SizedBox(height: 5),
                    _buildButton("Sign Up", onTap: () async {
                      try {
                        await authService.register(
                          signupFirstNameController.text.trim(),
                          signupLastNameController.text.trim(),
                          signupEmailController.text.trim(),
                          signupPasswordController.text.trim(),
                        );

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.bottomSlide,
                          title: 'Registrasi Berhasil',
                          desc: 'Silakan login menggunakan akun Anda',
                          btnOkOnPress: () => setState(() => animate = false),
                        ).show();
                      } catch (e) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.bottomSlide,
                          title: 'Registrasi Gagal',
                          desc: 'Coba Lagi',
                          btnOkOnPress: () {},
                        ).show();
                      }
                    }),
                    SizedBox(height: 10),
                    Text("Already Registered?",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => setState(() => animate = false),
                      child: Text("Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthCard({
    required Size screenSize,
    required String title,
    required List<Widget> fields,
    required Widget bottomWidget,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 80),
      width: screenSize.width * .8,
      height: screenSize.height * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(.10)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(.10),
                  Colors.white.withOpacity(.1),
                ],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Text(title,
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  ...fields,
                  SizedBox(height: 10),
                  bottomWidget,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label,
      {required TextEditingController controller, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildButton(String text, {required VoidCallback onTap}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 20, 24, 255).withOpacity(.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(.5),
            blurRadius: 15,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * .20);
    path.lineTo(0, size.height);
    path.lineTo(size.width * .9, size.height);
    path.quadraticBezierTo(
        size.width * .6, size.height * .8, size.width * .8, size.height * .7);
    path.quadraticBezierTo(
        size.width * .95, size.height * .6, size.width * .9, size.height * .5);
    path.quadraticBezierTo(
        size.width * .85, size.height * .40, size.width, size.height * .3);
    path.lineTo(size.width, size.height * .05);
    path.quadraticBezierTo(
        size.width * .9, size.height * .2, size.width * .6, size.height * .14);
    path.quadraticBezierTo(
        size.width * .2, size.height * .05, 0, size.height * .3);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
