import 'package:equatable/equatable.dart';

abstract class HubState extends Equatable {
  //const GalleryState();
}

class InitialHubState extends HubState {
  @override
  List<Object> get props => [];
}
