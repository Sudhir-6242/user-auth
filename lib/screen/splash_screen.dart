import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:user_auth/screen/loginscreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void signout() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signout, icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Center(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome To',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Text(
              'user auth app',
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 95, 95, 95)),
            ),
          ],
        )),
      ),
    );
  }
}
