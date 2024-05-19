import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'APIfile.dart';

class MySignUp extends StatelessWidget {
  const MySignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/SignUp_origin.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Scroll 가능하도록 설정
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 100,
            height: 300,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                width: 16.0,
                height: 50,
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 50.0),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'E-mail',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 50.0),
          ElevatedButton(
            onPressed: () async {
              // Handle sign up logic here -> 입력받은 값들임
              String username = _usernameController.text;
              String password = _passwordController.text;
              String email = _emailController.text;

              //Register API CALL
              // 요청할 데이터를 Map으로 구성합니다.
              Future<bool> checkRegister = allApi().signUp(username, password, email);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Checking your ID is duplicating.....'),
                    duration: const Duration(milliseconds: 700),
                  )
              );
              await Future.delayed(Duration(seconds: 2));
              // Duration time = Duration(seconds: 2);
              // await Future.delayed(Duration(seconds: 2));
              bool realdata = await checkRegister;
              if (realdata) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sign Up Successed!'),
                      duration: const Duration(milliseconds: 700),
                    )
                );
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Your Id is duplicated. Enter another ID'),
                      duration: const Duration(milliseconds: 700),
                    )
                );
              }

              await Future.delayed(Duration(seconds: 1));
              // You can perform validation or sign up operation here
              //이걸 print 해본거임
              print('UserName: $username');
              print('Password: $password');
              print('Email: $email');

              //여기서 이 값들을 바탕으로 로그인 정보를 만들어서 회원가입 시키면 됨
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(
                  Size(200, 50)), // 버튼의 크기를 가로 200, 세로 50으로 변경
            ),
            child: Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}