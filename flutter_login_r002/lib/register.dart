import 'package:flutter/material.dart';
import 'package:flutter_login_r002/helpers/dbhelper.dart';

import 'models/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  DbHelper dbHelper = new DbHelper();

  bool doValidation() {
    FormState form = this.formKey.currentState;
    return form.validate();
  }

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
                  child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: Text('Register',
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
                                  // ignore: missing_return
                                  controller: usernameController,
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return 'Username belum diisi';
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'username',
                                      labelText: 'Username',
                                      icon: Icon(Icons.person))),
                              TextFormField(
                                  // ignore: missing_return
                                  controller: passwordController,
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return 'password belum diisi';
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'password',
                                      labelText: 'Password',
                                      icon: Icon(Icons.lock))),
                              TextFormField(
                                  // ignore: missing_return
                                  controller: emailController,
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return 'email belum diisi';
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'email',
                                      labelText: 'Email',
                                      icon: Icon(Icons.email))),
                            ],
                          ),
                        ),
                        Expanded(
                          child: FloatingActionButton(
                              onPressed: () {
                                if (doValidation()) {
                                  //baca data dari form simpan ke objek user
                                  User user = new User(
                                      usernameController.text,
                                      passwordController.text,
                                      emailController.text);
                                  //insert data object user ke table users pada SQLite
                                  dbHelper.insertUser(user).then((count) {
                                    if (count > 0) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("user " +
                                            usernameController.text +
                                            " berhasil ditambahkan"),
                                        backgroundColor: Colors.green,
                                      ));

                                      //pastikan data user masuk ke database sqlite
                                      dbHelper
                                          .selectAllUser()
                                          .then((recordList) {
                                        recordList.forEach((record) {
                                          print(record);
                                        });
                                      });

                                      Navigator.pushNamed(context, '/login');
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("user " +
                                            usernameController.text +
                                            " gagal ditambahkan"),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  });
                                }
                              },
                              child: Icon(Icons.send)),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Back To Login'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                      ),
                    ),
                  ],
                ),
              )),
            )));
  }
}
