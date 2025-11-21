import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'bloc_manager.dart';
import 'broadcast.dart';

const Key forceDisposeBloc = Key('force_to_dispose_bloc');

abstract class BaseBloc<E extends Object, S extends Equatable>
    extends Bloc<E, S> {
  final Key key;
  final Key? closeWithBlocKey;

  BaseBloc(
    this.key, {
    required S initialState,
    this.closeWithBlocKey,
  }) : super(initialState) {
    otherBlocsSubscription();
  }

  @override
  Future<void> close() async {
    if (closeWithBlocKey != null && closeWithBlocKey != forceDisposeBloc) {
      return;
    }

    BlocManager().unsubscribes(key);
    BlocManager().remove(key);

    otherBlocsUnSubscription();

    await super.close();
  }

  void otherBlocsSubscription() {}

  void otherBlocsUnSubscription() {}

  List<Broadcast>? subscribes() {
    return null;
  }

  void addLater(
    Object event, {
    Duration after = const Duration(milliseconds: 300),
  }) {
    Future.delayed(after, () {
      add(event as E);
    });
  }
}
