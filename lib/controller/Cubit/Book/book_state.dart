part of 'book_cubit.dart';

@immutable
abstract class BookState {}

class BookInitial extends BookState {}

class GetBookLoading extends BookState {}

class GetBookSuccess extends BookState {}

class GetBookError extends BookState {}
