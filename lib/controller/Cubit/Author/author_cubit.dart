import 'dart:io';
import 'package:book_store/Const/component/component.dart';
import 'package:book_store/model/book.dart';
import 'package:book_store/model/books_model.dart';
import 'package:book_store/view/Screens/Autor/AuthHome.dart';
import 'package:book_store/view/Screens/Autor/add_file.dart';
import 'package:book_store/view/Screens/Autor/add_image.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/helper/dio_helper/dio_helper.dart';
import 'package:book_store/helper/shared_prefrences/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

part 'author_state.dart';

class AuthorCubit extends Cubit<AuthorState> {
  AuthorCubit() : super(AuthorInitial());

  static AuthorCubit get(context) => BlocProvider.of(context);

  String? category = 'Business';

  BookModel? bookModel;

  ///Add Book Data
  void addBook({
    required String name,
    required String description,
    required int price,
    required BuildContext context,
  }) async {
    emit(AddBookLoading());
    DioHelper.postData(
        url: ApiUrl.book,
        token: CacheHelper.getData(key: 'token'),
        isJsonContentType: true,
        data: {
          "name": name,
          "description": description,
          "genre": category,
          "price": price
        }).then((value) {
      print("This is statuscode: ${value.statusCode}");
      print("This is data: ${value.data}");
      if (value.statusCode == 200) {
        replaceTo(context, const AddImage());
        bookModel = BookModel.fromJson(value.data);
        int id = bookModel!.content!.book!.bId!;
        print('This is Id: $id');
        CacheHelper.saveData(key: 'bookId', value: id);
      } else {
        print('Something went wrong !');
      }
      emit(AddBookSuccess());
    }).catchError((e) {
      emit(AddBookError());
    });
  }

  ///edit Book Data
  void editBook({
    required String name,
    required String description,
    required int price,
    required BuildContext context,
  }) async {
    emit(AddBookLoading());
    DioHelper.putData(
        url: ApiUrl.book,
        token: CacheHelper.getData(key: 'token'),
        data: {
          "name": name,
          "description": description,
          "genre": category,
          "price": price
        }).then((value) {
      print("This is statuscode: ${value.statusCode}");
      print("This is data: ${value.data}");
      if (value.statusCode == 200) {
        replaceTo(context, const AddImage());
        bookModel = BookModel.fromJson(value.data);
        int id = bookModel!.content!.book!.bId!;
        print('This is Id: $id');
        CacheHelper.saveData(key: 'bookId', value: id);
      } else {
        print('Something went wrong !');
      }
      emit(AddBookSuccess());
    }).catchError((e) {
      emit(AddBookError());
    });
  }


  File? image;

  chooseBookImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    emit(ChooseBookImageState());
  }

  void addBookImage(
      {required int bookId, required BuildContext context}) async {
    emit(UploadImageLoading());
    DioHelper.postData(
        containImage: true,
        url: "${ApiUrl.book}/$bookId/image",
        token: CacheHelper.getData(key: "token"),
        data: {
          "book_id": bookId,
          "image": await MultipartFile.fromFile(image!.path,
              filename: image!
                  .path
                  .split('/')
                  .last,
              contentType: MediaType('image', 'jpg')),
        }).then((value) {
      print("This is status code:${value.statusCode}");
      if (value.statusCode == 200) {
        replaceTo(context, const AddFile());
        print("This Book Image Updated Successfully !");
      } else {
        print("Somthing went wrong !");
      }
      emit(UploadImageSuccess());
    }).catchError((e) {
      emit(UploadImageError());
    });
  }

  PlatformFile? file;
  String name = '';
  File? _file;

  choosefile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      name = result.files.single.name;
      file = result.files.first;
      print(file!.name);
      print(file!.path);
      _file = File(result.files.single.path ?? '');
    } else {
      print('User Cancelled !');
    }
    emit(ChooseBookFileState());
  }

  void addBookFile({required int bookId, required BuildContext context}) async {
    emit(UploadFileLoading());
    DioHelper.postData(
        containImage: true,
        isJsonContentType: false,
        url: "${ApiUrl.book}/$bookId/file",
        token: CacheHelper.getData(key: "token"),
        data: {
          "book_id": bookId,
          "file": await MultipartFile.fromFile(
            _file!.path,
            filename: '${file!.path!.split('/').last}.pdf',
            contentType: MediaType('application', 'pdf'),
          ),
        }).then((value) {
      print("This is status code:${value.statusCode}");
      print(value.data);
      if (value.statusCode == 200) {
        print(value.data);
        navigateAndFinish(context, const AuthHome());
        print("This Book File Uploaded Successfully !");
      } else {
        print("Somthing went wrong !");
      }
      emit(UploadFileSuccess());
    }).catchError((e) {
      emit(UploadFileError());
      print(e.toString());
    });
  }

BooksModel? booksModel;

  void getAuthorBooks() {
    emit(GetAuthorBooksLoading());
    DioHelper.getData(
      url: '${ApiUrl.book}/all',
      token: CacheHelper.getData(key: "token"),
      query: {
        'author_id': CacheHelper.getData(key: "authId")
      },
    ).then((value) {
      if(value.statusCode==200){
        booksModel=BooksModel.fromJson(value.data);
        print('Author Books get Successfully');
        print(value.data);
      }
      emit(GetAuthorBooksSuccess());
    }).catchError((e){
      emit(GetAuthorBooksError());
      print(e.toString());
    });
  }
}
