
import 'package:finful_app/app/data/model/user.dart';

abstract class SessionEvent {
  const SessionEvent();
}

class SessionLoaded extends SessionEvent {}

class SessionUserLoggedIn extends SessionEvent {
  final User loggedInUser;

  SessionUserLoggedIn(this.loggedInUser);
}

class SessionUserLogOutSubmitted extends SessionEvent {
  SessionUserLogOutSubmitted();
}

class SessionForceUserSignInStarted extends SessionEvent {}