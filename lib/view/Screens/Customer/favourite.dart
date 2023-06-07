import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerCubit()..getAllFavItems(),
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
                :
            ListView.separated(
              itemBuilder: (context, index) => SizedBox(),
              // FavoriteItem(
              //   favId: cubit.favItems[index].favId,
              //   bookId: cubit.favItems[index].bookId,
              //   bookName: cubit.favItems[index].bookName!,
              //   description:
              //   cubit.favItems[index].description!,
              // )
              separatorBuilder: (context, index) => SizedBox(height: 30.h),
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
