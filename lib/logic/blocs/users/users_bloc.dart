// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:idoc_admin_side/data/repositories/user_repository.dart';
// import 'package:idoc_admin_side/logic/blocs/users/users_event.dart';
// import 'package:idoc_admin_side/logic/blocs/users/users_state.dart';

// class UsersBloc extends Bloc<UsersEvent, UsersState> {
//   final UserRepository _repository = UserRepository();

//   UsersBloc() : super(UsersInitialState()) {
//     on<LoadUsersEvent>(_onLoadUsers);
//   }

//   void _onLoadUsers(
//     LoadUsersEvent event,
//     Emitter<UsersState> emit,
//   ) {
//     emit(UsersLoadingState());
//     _repository.getAllUsers().listen(
//       (users) {
//         emit(UsersLoadedState(users));
//       },
//       onError: (error) {
//         emit(UsersErrorState(error.toString()));
//       },
//     );
//   }
// }





