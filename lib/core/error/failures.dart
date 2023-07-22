
abstract class Failure  {}

class OfflineFailure extends Failure {

}
class ServerFailure extends Failure {

}
class EmptyCacheFailure extends Failure {

}


// import 'package:alfa_lab/imports/packages_import.dart';
//
// abstract class Failure extends Equatable {
//   final String msg;
//
//   const Failure({required this.msg});
// }
//
// class NoInternetFailure extends Failure {
//   const NoInternetFailure(
//       {super.msg = 'Internet Connection | Check your network connection.'});
//
//   @override
//   List<Object> get props => [msg];
// }
//
// class ServerFailure extends Failure {
//   const ServerFailure({super.msg = 'Something went wrong'});
//
//   @override
//   List<Object> get props => [msg];
// }
//
// class EmptyCacheFailure extends Failure {
//   const EmptyCacheFailure({required super.msg});
//
//   @override
//   List<Object> get props => [msg];
// }
//
// class EmptyListFailure extends Failure {
//   const EmptyListFailure({super.msg = 'Empty List'});
//
//   @override
//   List<Object?> get props => [msg];
// }
