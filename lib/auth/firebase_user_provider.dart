import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Ls0FirebaseUser {
  Ls0FirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

Ls0FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Ls0FirebaseUser> ls0FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Ls0FirebaseUser>((user) => currentUser = Ls0FirebaseUser(user));
