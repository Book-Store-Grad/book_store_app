import 'package:book_store/Const/const.dart';
import 'package:book_store/controller/AppController/app_controller_cubit.dart';
import 'package:book_store/helper/dio_helper/dio_helper.dart';
import 'package:book_store/view/Screens/Auth/login.dart';
import 'package:book_store/view/layout/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'helper/shared_prefrences/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp

  ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppControllerCubit(),
      child: BlocConsumer<AppControllerCubit, AppControllerState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) =>
                  GetMaterialApp(
                      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
                      debugShowCheckedModeBanner: false,
                      home: token != null && role == 'customer'
                          ? const LayoutScreen() : const Login())
          );
        },
      ),
    );
  }
}
