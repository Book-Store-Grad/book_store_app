import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:book_store/view/widgets/FavItem.dart';
import 'package:book_store/view/widgets/buttonfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerCubit()..getAllCartItems(),
      child: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {},
        builder: (context, state) {
          CustomerCubit cubit = CustomerCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: const Text(
                'Cart',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: state is GetAllCartLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (context, index) => state
                                is RemoveFromCartLoading &&
                            cubit.cartIndex == index
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: CircularProgressIndicator(color: Colors.red),
                          ))
                        : cubit.cartItems.isEmpty
                            ? Center(
                                child: Text(
                                  'No Books added to Cart....!',
                                  style: GoogleFonts.akayaKanadaka(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                                  child: DefaultButton(function: (){},
                                    text: 'Process To Checkout',
                                    width: 300.w,
                                    textSize: 18,
                                  ),
                                ),
                                Dismissible(
                                    key: Key('$index'),
                                    onDismissed: (d) {
                                      cubit.removeFromCart(
                                          cartId: cubit.cartItems[index].caiId!,
                                          index: index);
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
                                      bookId: cubit.cartItems[index].bId!,
                                      bookName: cubit.cartItems[index].bName!,
                                      price: cubit.cartItems[index].bPrice!,
                                      bookImage: ' ',
                                    ),
                                  ),
                              ],
                            ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemCount: cubit.cartItems.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                  ),
          );
        },
      ),
    );
  }
}
