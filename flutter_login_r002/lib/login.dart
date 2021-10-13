import 'package:flutter/material.dart';

import 'helpers/dbhelper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //objek controller
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DbHelper dbHelper = new DbHelper();

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
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                      hintText: 'username',
                                      labelText: 'Username',
                                      icon: Icon(Icons.person))),
                              TextFormField(
                                controller: passwordController,
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
                              onPressed: () {
                                //1. membaca data username dan pasword yang diinputkan
                                String username = usernameController.text;
                                String password = passwordController.text;
                                //2. mengecek tabel users apakah user tersebut ada
                                dbHelper
                                    .selectUser(username, password)
                                    .then((recordList) {
                                  if (recordList.length > 0) {
                                    //3. jika user tersebut ada dan password benar, login berhasil dan navigasi ke halaman dashboadr
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("login berhasil"),
                                      backgroundColor: Colors.green,
                                    ));
                                    Navigator.pushNamed(context, '/dashboard');
                                  } else {
                                    //4. jika user tidak ada/passwor salah, tampil pesan login gagal
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("login gagal"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                });
                              },
                              child: Icon(Icons.login)),
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
