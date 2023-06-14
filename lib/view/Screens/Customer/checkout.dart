import 'package:book_store/Const/component/component.dart';
import 'package:book_store/controller/AppController/app_controller_cubit.dart';
import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:book_store/view/Screens/Customer/customer_home.dart';
import 'package:book_store/view/layout/app_layout.dart';
import 'package:book_store/view/widgets/FavItem.dart';
import 'package:book_store/view/widgets/buttonfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = 400;
    return BlocProvider(
      create: (context) => CustomerCubit()..getAllCartItems(),
      child: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {},
        builder: (context, state) {
          CustomerCubit cubit = CustomerCubit.get(context);
          return Scaffold(
            backgroundColor: Color(0xfff8f1f1),
            appBar: AppBar(
              elevation: 1,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: const Text(
                "Checkout",
                style: TextStyle(color: Colors.black),
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            body: state is GetAllCartLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : cubit.cartItems.isEmpty
                    ? Center(
                        child: Text(
                          'No Books added to Cart....!',
                          style: GoogleFonts.akayaKanadaka(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: const [
                                    Text(
                                      'By placing your order you agree to BookStore.com',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      'privacy notice, Conditions of use and sale',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total price',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp),
                                    ),
                                    Text(
                                      '$total EGP',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.sp),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Books in order',
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                height: 270.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          FavoriteItem(
                                            bookId: cubit.cartItems[index].bId!,
                                            bookName:
                                                cubit.cartItems[index].bName!,
                                            price:
                                                cubit.cartItems[index].bPrice!,
                                            bookImage: '',
                                          ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 10.h),
                                      itemCount: cubit.cartItems.length),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  'Payment',
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/payment.png",
                                    height: 100.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              BlocConsumer<AppControllerCubit,
                                  AppControllerState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  AppControllerCubit appCubit =
                                      AppControllerCubit.get(context);
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30.0),
                                    child: state is OrderLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.red,
                                            ),
                                          )
                                        : DefaultButton(
                                            function: () {
                                              cubit.addorder(onSuccess: () {
                                                Get.snackbar("Success", "",
                                                    maxWidth: 400,
                                                    messageText: const Text(
                                                      "Order Placed Successfully !",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    icon: const Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                      size: 30,
                                                    ),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: .1.sh,
                                                            horizontal: .1.sw));
                                                cubit.cartItems = [];
                                                appCubit.currentIndex = 0;
                                                navigateTo(context,
                                                    const LayoutScreen());
                                              });
                                            },
                                            text: 'Place your order',
                                            textSize: 18,
                                          ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
          );
        },
      ),
    );
  }
}
