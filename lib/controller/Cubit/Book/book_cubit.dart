import 'package:bloc/bloc.dart';
import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/Const/const.dart';
import 'package:book_store/helper/dio_helper/dio_helper.dart';
import 'package:book_store/model/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());

  static BookCubit get(context) => BlocProvider.of(context);
  Book? book;

  void getBook({required int bookId}) async {
    emit(GetBookLoading());
    DioHelper.getData(
      url: '${ApiUrl.book}/$bookId',
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        book = Book.fromJson(value.data['content']['book']);
        print('Book get Successfully !');
        print(value.data);
      }
      emit(GetBookSuccess());
    }).catchError((onError) {
      emit(GetBookError());
      print(onError.toString());
    });
  }
}
