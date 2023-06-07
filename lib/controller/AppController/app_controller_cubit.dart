import 'package:bloc/bloc.dart';
import 'package:book_store/view/Screens/Customer/customer_home.dart';
import 'package:book_store/view/Screens/Customer/favourite.dart';
import 'package:book_store/view/Screens/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_controller_state.dart';

class AppControllerCubit extends Cubit<AppControllerState> {
  AppControllerCubit() : super(AppControllerInitial());
  static AppControllerCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;
   List<Widget> BottomScreens=[
     const CusHome(),
     const FavoritePage(),
     const CusHome(),
     const ProfileScreen(),
   ];
  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(ChangeBottomState());
  }

}
