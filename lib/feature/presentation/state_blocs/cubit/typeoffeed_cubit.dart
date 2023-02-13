import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'typeoffeed_state.dart';

class TypeoffeedCubit extends Cubit<TypeoffeedState> {
  TypeoffeedCubit() : super(TypeoffeedInitial());

  feedViewList() => emit(TypeOfFeedListState());

  feedViewTile() => emit(TypeOfFeedTileState());
}
