import 'dart:ui';
import 'package:flutter/material.dart';

class ClipLogin19 extends StatefulWidget {
  const ClipLogin19({Key? key}) : super(key: key);

  @override
  State<ClipLogin19> createState() => _ClipLogin19State();
}

class _ClipLogin19State extends State<ClipLogin19> {
  bool animate=false;

  @override
  Widget build(BuildContext context) {
    Size screenSize =MediaQuery.of(context).size;
    const myColor= Color.fromARGB(255, 0, 0, 0);
    // const myColor2= Color.fromRGBO(0, 0, 0, 1);
    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
        child: Stack(
          children: [

//bg 
            ClipPath(
  clipper: MyClipper(),
  child: Image.asset(
    'assets/images/aston.jpg', // atau gunakan Image.network('url')
    width: screenSize.width,
    height: screenSize.height,
    fit: BoxFit.cover,
  ),
),

 //lingkaran
            // Positioned(
            //   top: screenSize.height/3.9,
            //   left: screenSize.width/3.5,
            //   child: Container(
            //     width: 100,
            //     height: 100,
            //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: const Color.fromARGB(255, 234, 255, 139)),
            //   ),
            // ),
            // Positioned(
            //   top: screenSize.height*.9,
            //   left: screenSize.width*.9,
            //   child: Container(
            //     width: 60,
            //     height: 60,
            //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: const Color.fromARGB(255, 99, 67, 255)),
            //   ),
            // ),
            // Positioned(
            //   top: screenSize.height*.5,
            //   left: screenSize.width*.7,
            //   child: Container(
            //     width: 60,
            //     height: 60,
            //     decoration: BoxDecoration(
            //         backgroundBlendMode: BlendMode.modulate,
            //         borderRadius: BorderRadius.circular(50),color: const Color.fromARGB(255, 228, 233, 90)),

            //   ),
            // ),
            // Positioned(
            //   top: screenSize.height*.6,
            //   left: screenSize.width*.05,
            //   child: Container(
            //     width: 70,
            //     height: 70,
            //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: myColor),
            //   ),
            // ),

            // ClipPath(
            //   clipper: MyClipper2(),
            //   child: Container(height: screenSize.height/4,width: screenSize.width,
            //     decoration: BoxDecoration(
            //         backgroundBlendMode: BlendMode.multiply  ,
            //         gradient: LinearGradient(
            //             begin: Alignment.topLeft,
            //             end: Alignment.bottomCenter,
            //             colors:[
            //               Color.fromRGBO(255, 255, 255, 1),
            //               Color.fromRGBO(255, 255, 255, 1),
            //               Color.fromRGBO(63, 117, 255, 1),
            //               Color.fromRGBO(62, 97, 255, 1),
            //             ]
            //         )
            //     ),),
            // ),
            // ClipPath(
            //   clipper: MyClipper3(),
            //   child: Container(height: screenSize.height,width: screenSize.width,
            //     decoration: BoxDecoration(
            //         backgroundBlendMode: BlendMode.multiply  ,
            //         gradient: LinearGradient(
            //             begin: Alignment.bottomRight,
            //             end: Alignment.center,
            //             colors:[
            //                Color.fromRGBO(255, 228, 56, 1),
            //               Color.fromRGBO(202, 191, 120, 1),
            //               Color.fromRGBO(255, 255, 255, 1),
            //               Color.fromRGBO(255, 255, 255, 1),
            //             ]
            //         )
            //     ),),
            // ),
            
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              top: animate ? -screenSize.height*.85: 0,
              left: 40,
              child: Container(
                padding:  EdgeInsets.only(top: 80,),
                width: screenSize.width*.8,
                height: screenSize.height*.9,
                child: ClipRRect(borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        BackdropFilter(filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                          child: Container(),),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(.10),),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(.10),
                                    Colors.white.withOpacity(.1)
                                  ]
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenSize.height*.06,left: 10,right: 10),

                          child: Column(
                            children: [
                              const Text("Sign In",style: TextStyle(fontSize: 35,color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
                              const SizedBox(height: 15,),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                obscureText: true,
                                scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                decoration: const InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                alignment: Alignment.centerRight,
                                child: const Text('Forgot password?',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                              ),
                              const SizedBox(height: 20,),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(color: Colors.white.withOpacity(.2),
                                    boxShadow: [BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 10,
                                        offset: const Offset(0,5)
                                    )],
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.pushReplacementNamed(context, '/dashboard');
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      shadowColor: Colors.transparent,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                  ),
                                  child: const Text('Sign In',style: TextStyle(color: myColor,fontSize: 30),),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              const Text("Don't have an account?",style: TextStyle(color: Colors.white,
                                  shadows:[ Shadow(
                                      color: Colors.black87,
                                      blurRadius: 10,
                                      offset: Offset(0,4)
                                  )]
                              ),
                              ),
                              const SizedBox(height: 10,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    animate=true;
                                  });
                                },
                                child: const Text("Register",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 20,
                                    shadows:[ Shadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        offset: Offset(0,4)
                                    )],
                                ),
                                ),
                              ),
                              // const SizedBox(height: 10,),
                              // Container(
                              //   margin: const EdgeInsets.only(left: 30),
                              //   alignment: Alignment.centerLeft,
                              //   child: const Text("Or ",style: TextStyle(color: myColor,fontSize: 15,
                              //       shadows:[ Shadow(
                              //           color: Colors.grey,
                              //           blurRadius: 10,
                              //           offset: Offset(0,4)
                              //       )]
                              //   ),
                              //   ),
                              // ),
                              // Container(margin: const EdgeInsets.only(top: 15),
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(20),
                              //       color: Colors.white.withOpacity(.1),
                              //       boxShadow: [BoxShadow(
                              //           color: Colors.grey.withOpacity(.7),
                              //           blurRadius: 15,
                              //           offset: const Offset(0,3)
                              //       )]
                              //   ),
                              //   child: const ListTile(
                              //     leading: Icon(Icons.android,color: myColor,),
                              //     title: Text('Login with Google',style: TextStyle(color: myColor,),),
                              //     trailing: Icon(Icons.arrow_forward_ios,color: myColor,),
                              //   ),
                              // ),
                              // Container(margin: const EdgeInsets.only(top: 15),
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(20),
                              //       color: Colors.white.withOpacity(.1),
                              //       boxShadow: [BoxShadow(
                              //           color: Colors.grey.withOpacity(.7),
                              //           blurRadius: 15,
                              //           offset: const Offset(0,3)
                              //       )]
                              //   ),
                              //   child: const ListTile(
                              //     leading: Icon(Icons.apple,color: myColor,),
                              //     title: Text('Login with Apple',style: TextStyle(color: myColor, ),),
                              //     trailing: Icon(Icons.arrow_forward_ios,color: myColor,),
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),),


              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              top: animate ? 0: screenSize.height*.85,
              left: 40,
              child: Container(
                padding: const EdgeInsets.only(top: 80),
                width: screenSize.width*.8,
                height: screenSize.height*.9,
                child: ClipRRect(borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        BackdropFilter(filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                          child: Container(),),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(.10),),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withOpacity(.10),
                                    Colors.white.withOpacity(.1)
                                  ]
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: screenSize.height*.06,left: 20,right: 20),

                          child: Column(
                            children: [
                              const Text("Sign Up",style: TextStyle(fontSize: 35,color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold),),
                              const SizedBox(height: 15,),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))
                                ),
                              ),
                              const SizedBox(height: 15,),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))
                                ),
                              ),
                              const SizedBox(height: 15,),
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                obscureText: true,
                                scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                decoration: const InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))
                                ),
                              ),
                              // const SizedBox(height: 20),
                              // TextFormField(
                              //   obscureText: true,
                              //   scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              //   decoration: const InputDecoration(
                              //       labelText: 'Confirm Password',
                              //       labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255))
                              //   ),
                              // ),

                              const SizedBox(height: 20,),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255).withOpacity(.2),
                                    boxShadow: [BoxShadow(
                                        color: Colors.grey.withOpacity(.5),
                                        blurRadius: 10,
                                        offset: const Offset(0,5)
                                    )],
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: ElevatedButton(
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      shadowColor: Colors.transparent,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                                  ),
                                  child: const Text('Sign Up',style: TextStyle(
                                      color: myColor,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold
                                  ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              const Text("Already Registered?",style: TextStyle(color: Colors.white,
                                  shadows:[ Shadow(
                                      color: Colors.black87,
                                      blurRadius: 10,
                                      offset: Offset(0,4)
                                  )]
                              ),
                              ),
                              const SizedBox(height: 20,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    animate=false;
                                  });
                                },
                                child: const Text("Sign In",style: TextStyle(color: myColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    shadows:[ Shadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        offset: Offset(0,4)
                                    )]
                                ),
                                ),
                              ),
                              // const SizedBox(height: 10,),



                            ],
                          ),
                        )
                      ],
                    ),
                  ),),


              ),
            ),

          ],
        ),
      ),
    ),
    );
  }
}

// class MyClipper3 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path= Path();
//     path.moveTo(size.width/2, size.height);
//     path.quadraticBezierTo(size.width*.5, size.height*.9, size.width*.6,size.height*.86);
//     path.quadraticBezierTo(size.width*.75, size.height*.8, size.width*.8,size.height*.75);
//     path.quadraticBezierTo(size.width*.85, size.height*.7, size.width*.82,size.height*.6);
//     path.quadraticBezierTo(size.width*.8, size.height*.5, size.width,size.height*.5);
//     path.lineTo(size.width, size.height);
//     return path;

//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// class MyClipper2 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path=Path();
//     path.lineTo(0, size.height*.9);
//     path.quadraticBezierTo(size.width/4, size.height*.8, size.width*.38, size.height*.5);
//     path.quadraticBezierTo(size.width*.47, size.height*.25, size.width*.6, size.height*.33);
//     path.quadraticBezierTo(size.width*.75, size.height*.4, size.width*.85, size.height*.26);
//     path.quadraticBezierTo(size.width*.95, size.height*.1, size.width*.93, size.height*.3);
//     path.quadraticBezierTo(size.width*.9, size.height*.5, size.width, size.height*.7);
//     path.lineTo(size.width, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path=Path();
    path.moveTo(0,size.height*.20 );
    path.lineTo(0, size.height);
    path.lineTo(size.width*.9, size.height);
    path.quadraticBezierTo(size.width*.6, size.height*.8, size.width*.8, size.height*.7);
    path.quadraticBezierTo(size.width*.95, size.height*.6, size.width*.9, size.height*.5);
    path.quadraticBezierTo(size.width*.85, size.height*.40, size.width, size.height*.3);
    path.lineTo(size.width, size.height*.05);
    path.quadraticBezierTo(size.width*.9, size.height*.2, size.width*.6, size.height*.14);
    path.quadraticBezierTo(size.width*.2, size.height*.05, 0, size.height*.3);
    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
