abstract class LoaderEvent {
  const LoaderEvent();
}

class LoaderStarted extends LoaderEvent {}

class LoaderStopped extends LoaderEvent {}
