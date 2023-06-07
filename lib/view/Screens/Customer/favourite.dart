import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:book_store/view/widgets/FavItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      CustomerCubit()
        ..getAllFavItems(),
      child: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {},
        builder: (context, state) {
          CustomerCubit cubit = CustomerCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: const Text(
                'Favorites',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: state is GetAllFavouriteLoading
                ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.only(top: 20),
              itemBuilder: (context, index) =>
                  Dismissible(
                    key: UniqueKey(),
                    onDismissed: (d) {
                      cubit.removeFromFav(favId: cubit.favItems[index].faId!);
                    },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.only(left: .5.sw),
                        child: const Icon(
                          Icons.delete,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: FavoriteItem(
                        favId: cubit.favItems[index].faId!,
                        bookId: cubit.favItems[index].bId!,
                        bookName: cubit.favItems[index].bName!,
                        price: cubit.favItems[index].bPrice!.toString()),
                  ),
              separatorBuilder: (context, index) =>
                  SizedBox(
                      height: 10.h),
              itemCount: cubit.favItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          );
        },
      ),
    );
  }
}
