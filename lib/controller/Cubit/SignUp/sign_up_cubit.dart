import 'package:bloc/bloc.dart';
import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/Const/component/component.dart';
import 'package:book_store/helper/dio_helper/dio_helper.dart';
import 'package:book_store/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store/model/Signup.dart';
import 'package:book_store/view/Screens/Auth/login.dart';
import 'package:book_store/view/Screens/Autor/AuthHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit get(context) => BlocProvider.of(context);

  SignUpModel? signupModel;
  String gender = "Male";

  void signup(
      {required String userName,
      required String password,
      required String email,
      required String gender,
      required BuildContext context}) {
    emit(SignUpLoadingState());

    DioHelper.postData(isJsonContentType: true, url: ApiUrl.signup, data: {
      "email": email,
      "name": userName,
      "password": password,
      "gender": gender,
      "role": CacheHelper.getData(key: "signupRole")
    }).then((value) {
      print("This is statuscode: ${value.statusCode}");
      print("This is data: ${value.data}");
      if (value.statusCode == 200) {
        signupModel = SignUpModel.fromJson(value.data);
        CacheHelper.saveData(key: "token", value: signupModel!.accessToken);
        CacheHelper.saveData(
            key: "role", value: signupModel!.content!.customer!.cuRole);
        print("this is token : ${CacheHelper.getData(key: "token")}");
        print("account role : ${CacheHelper.getData(key: "role")}");
        navigateTo(context, const Login());
      } else {
        Get.snackbar("Error", "",
            maxWidth: 400,
            messageText: const Text(
              "Please try again !",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: const Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            ),
            margin: EdgeInsets.symmetric(vertical: .1.sh, horizontal: .1.sw));
      }
      emit(SignUpSuccessState());
    }).catchError((e) {
      print("this:${e.toString()}");
      emit(SignUpErrorState());
    });
  }
}
