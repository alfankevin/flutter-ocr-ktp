import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image(
                      image: AssetImage('assets/images/login/scanner.png'),
                      height: 75.0,
                    ),
                    SizedBox(height: 25.0),
                    Text("Let's sign you in.", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                    SizedBox(height: 15.0),
                    Text("Sign in with your data that you have\nentered during your registration.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 1.5, 
                        fontSize: 16,
                        color: Colors.grey[500]
                      ),
                    ),
                  ]
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email", style: TextStyle(fontSize: 16, color: Colors.grey[500])),
                        Container(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'username@example.com',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(47, 79, 205, 1.0)),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            )
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text("Password", style: TextStyle(fontSize: 16, color: Colors.grey[500])),
                        Container(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'example123',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              // suffixIcon: Icon(Icons.visibility_off),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(47, 79, 205, 1.0)),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    Text("Forgot password?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold, 
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Color(0xFF2F4FCD),
                        minimumSize: Size(double.infinity, 50.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )
                      ),
                      child: Text("Sign in", style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(height: 25.0),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                        side: BorderSide(width: 1.0, color: Colors.grey),
                        minimumSize: Size(double.infinity, 50.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/login/google.svg',
                            width: 25.0,
                            height: 25.0,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            "Sign in with Google",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800]
                            ),
                          ),
                        ],
                      )
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: TextStyle(fontSize: 16, color: Colors.grey[500])),
                        Text("Register", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]))
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ),
      )
    );
  }
}