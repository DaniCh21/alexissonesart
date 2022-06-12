import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class HubBloc extends Bloc<HubEvent, HubState> {
  @override
  HubState get initialState => InitialHubState();

  @override
  Stream<HubState> mapEventToState(
      HubEvent event,
      ) async* {
    // TODO: Add Logic
  }
}
