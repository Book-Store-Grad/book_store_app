import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/Const/component/component.dart';
import 'package:book_store/controller/Cubit/Book/book_cubit.dart';
import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:book_store/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store/view/layout/app_layout.dart';
import 'package:book_store/view/widgets/buttonfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class GBookPage extends StatelessWidget {
  const GBookPage({Key? key, required this.bookId}) : super(key: key);
  final int bookId;

  @override
  Widget build(BuildContext context) {
    Future<bool> pop() async {
      replaceTo(context, const LayoutScreen());
      return false;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookCubit()..getBook(bookId: bookId)),
        BlocProvider(create: (context) => CustomerCubit()),
      ],
      child: BlocConsumer<BookCubit, BookState>(
        listener: (context, state) {},
        builder: (context, state) {
          BookCubit cubit = BookCubit.get(context);
          CustomerCubit customerCubit = CustomerCubit.get(context);
          return WillPopScope(
            onWillPop: pop,
            child: Scaffold(
              appBar: AppBar(
                elevation: 1,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: const Text(
                  "Book Details",
                  style: TextStyle(color: Colors.black),
                ),
                leading: GestureDetector(
                  onTap: () {
                    replaceTo(context, const LayoutScreen());
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              bottomSheet: cubit.book == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : Card(
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: BlocConsumer<CustomerCubit, CustomerState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  state is AddToFavouriteLoading?
                                      ? const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          child: CircularProgressIndicator(
                                            color: Colors.red,
                                          ),
                                        )
                                      : DefaultButton(
                                          width: .4.sw,
                                          textSize: 15.sp,
                                          height: 40.h,
                                          function: () {
                                            cubit.getBookFile(bookId: bookId);
                                            customerCubit.addToFavourite(
                                                bookId: bookId);
                                          },
                                          text: 'Add Favourite',
                                          background: Colors.red,
                                        ),
                                  SizedBox(width: 15.w),
                                  cubit.book!.isOwned! == true ||
                                          cubit.book!.isFree! == true ||
                                          cubit.book!.bPrice! == 0.0
                                      ? DefaultButton(
                                          width: .4.sw,
                                          textSize: 15.sp,
                                          height: 40.h,
                                          function: () {
                                            launch(
                                                '${ApiUrl.base}book/$bookId/file');
                                          },
                                          text: 'Download',
                                          background: Colors.green,
                                        )
                                      : state is AddToCartLoading?
                                          ? const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 50),
                                              child: CircularProgressIndicator(
                                                color: Colors.blue,
                                              ),
                                            )
                                          : DefaultButton(
                                              width: .4.sw,
                                              textSize: 15.sp,
                                              height: 40.h,
                                              function: () {
                                                customerCubit.addToCart(
                                                    bookId: bookId);
                                              },
                                              text: 'Add To Cart',
                                              background: Colors.blue,
                                            )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
              body: state is GetBookLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Center(
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 10,
                                    child: Container(
                                        width: 250.w,
                                        height: 300.h,
                                        child: Image.network(
                                          fit: BoxFit.cover,
                                          ApiUrl.photoBase +
                                              cubit.book!.coverImageUrl!,
                                          headers: {
                                            'Authorization':
                                                'Bearer ${CacheHelper.getData(key: 'token')}'
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Center(
                                            child: Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Image.asset(
                                                "assets/images/cover.png",
                                                width: 250.w,
                                                height: 300.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.book!.bName!,
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      cubit.book!.bPrice! == 0.0
                                          ? "Free"
                                          : '${cubit.book!.bPrice} EGP',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: cubit.book!.bPrice! == 0.0
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          cubit.book!.bGenre!,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.orange),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.0),
                                    child: Text(
                                      'Book description',
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    cubit.book!.bDescription!,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: .1.sh,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
