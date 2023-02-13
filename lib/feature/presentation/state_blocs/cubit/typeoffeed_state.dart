part of 'typeoffeed_cubit.dart';

abstract class TypeoffeedState extends Equatable {
  const TypeoffeedState();

  @override
  List<Object> get props => [];
}

class TypeoffeedInitial extends TypeoffeedState {}

class TypeOfFeedTileState extends TypeoffeedState {}

class TypeOfFeedListState extends TypeoffeedState {}
