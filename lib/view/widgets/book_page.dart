import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/Const/component/component.dart';
import 'package:book_store/controller/Cubit/Book/book_cubit.dart';
import 'package:book_store/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store/model/book.dart';
import 'package:book_store/model/recommendation.dart';

import 'package:book_store/view/layout/app_layout.dart';
import 'package:book_store/view/widgets/buttonfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GBookPage extends StatelessWidget {
  final int bookId;

  GBookPage({Key? key, required this.bookId}) : super(key: key);
  Book? book;

  @override
  Widget build(BuildContext context) {
    Future<bool> pop() async {
      replaceTo(context, const LayoutScreen());
      return false;
    }

    return BlocProvider(
      create: (context) => BookCubit()..getBook(bookId: bookId),
      child: BlocConsumer<BookCubit, BookState>(
        listener: (context, state) {
          if (state is GetBookSuccess) {
            book = state.book;
          }
        },
        builder: (context, state) {
          BookCubit cubit =BookCubit.get(context);
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
              bottomSheet: Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child:
                      // state is DeleteBookLoading
                      //     ? const Center(
                      //   child: CircularProgressIndicator(
                      //     color: Colors.red,
                      //   ),
                      // )
                      //     :
                      Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultButton(
                          width: .4.sw,
                          textSize: 15.sp,
                          height: 40.h,
                          function: () {},
                          text: 'Add Favourite',
                          background: Colors.red,
                        ),
                        SizedBox(width: 15.w),
                        DefaultButton(
                          width: .4.sw,
                          textSize: 15.sp,
                          height: 40.h,
                          function: () {},
                          text: 'Add To Cart',
                          background: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              body: state is GetBookLoading || book ==null
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
                                          ApiUrl.photoBase
                                          //+ book.coverImageUrl!
                                          ,
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
                                  ' book!.bName!',
                                    style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'tttttttt'
                                      // book!.bPrice! == 0.0
                                      //     ? "Free"
                                      //     : '${book!.bPrice} EGP',
                                      // style: TextStyle(
                                      //     fontSize: 16.sp,
                                      //     color: book!.bPrice! == 0.0
                                      //         ? Colors.green
                                      //         : Colors.red),
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
                                          book!.bGenre!,
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
                                    'book!.bDescription!',
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
