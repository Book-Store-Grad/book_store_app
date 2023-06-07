import 'package:book_store/controller/AppController/app_controller_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppControllerCubit, AppControllerState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppControllerCubit cubit = AppControllerCubit.get(context);
        return Scaffold(
          body: cubit.BottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.changeBottomScreen(index);
            },
            iconSize: 30,
            selectedItemColor: Colors.red,
            currentIndex: cubit.currentIndex,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  cubit.currentIndex == 0?
                  Icons.home_filled: Icons.home_outlined,
                  color: cubit.currentIndex == 0 ? Colors.red : Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Favourite',
                icon: Icon(
                  cubit.currentIndex == 1 ?
                  Icons.favorite: Icons.favorite_border,
                  color: cubit.currentIndex == 1 ? Colors.red : Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                icon: Icon(
                  cubit.currentIndex == 2 ?
                  Icons.shopping_cart : Icons.shopping_cart_outlined,
                  color: cubit.currentIndex == 2 ? Colors.red : Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(
                  cubit.currentIndex == 3 ?
                  Icons.person: Icons.person_outline,
                  color: cubit.currentIndex == 3 ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
