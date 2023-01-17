import 'package:finale/second.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  /// Keeps track of the username and password entered
  final GlobalKey<FormFieldState<String>> _usernameFormFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _passwordFormFieldKey = GlobalKey();

  /// Checking if value entered is empty
  _notEmpty(var value) => value != null && value.isNotEmpty;

  /// getter for username and password
  get values => ({
        'username': _usernameFormFieldKey.currentState?.value,
        'password': _passwordFormFieldKey.currentState?.value
      });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40.0),
            const Text(
              'Movie Tracker',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                fontFamily: 'LibreBaskerville',
              ),
            ),
            const SizedBox(height: 30.0),
            const Image(
              image: AssetImage('assets/images/movie.png'),
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 25),
                    TextFormField(
                      key: _usernameFormFieldKey,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.account_box),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          _notEmpty(value!) ? null : 'Username is required',
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      key: _passwordFormFieldKey,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          _notEmpty(value!) ? null : 'Password is required',
                    ),
                    const SizedBox(height: 25),
                    Builder(
                      builder: (context) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              child: const Text('Log In'),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (Form.of(context)!.validate()) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => const Second(),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(
                                  45.0,
                                  15.0,
                                  45.0,
                                  15.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            const SizedBox(width: 25),
                            ElevatedButton(
                              child: const Text('Sign up'),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (Form.of(context)!.validate()) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const Second(),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(
                                  45.0,
                                  15.0,
                                  45.0,
                                  15.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
}
