import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('./images/background.jpg'),
                    fit: BoxFit.cover)),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: Text('Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24)),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'username',
                                      labelText: 'Username',
                                      icon: Icon(Icons.person))),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'password',
                                    labelText: 'Password',
                                    icon: Icon(Icons.lock)),
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: FloatingActionButton(
                              onPressed: () {}, child: Icon(Icons.login)),
                        )
                      ],
                    ),
                    TextButton(
                        onPressed: () {}, child: Text('Forgot Password?')),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text('Register'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
