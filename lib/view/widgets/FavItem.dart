import 'package:book_store/Const/component/component.dart';
import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:book_store/view/widgets/book_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class FavoriteItem extends StatelessWidget {
  final int favId;
  final int bookId;
  final String bookName;
//  final String bookImage;
  final String price;
  const FavoriteItem({Key? key, required this.favId, required this.bookId, required this.bookName, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: (){
          navigateTo(context,GBookPage(bookId:bookId) );
        },
        child: Row(
          children: [
            Image.asset(
              'assets/images/cover.png',
              width: 90.w,
              height: 110.h,
              fit: BoxFit.fill,
            ),
            SizedBox(width: 10.w),
            SizedBox(
              width: .6.sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      bookName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 10.h),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.red,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            // const Spacer(),
            // InkWell(
            //   onTap: () {
            //     BlocProvider.of<CustomerCubit>(context, listen: false)
            //         .removeFromFav(favId: favId);
            //   },
            //   borderRadius: BorderRadius.circular(50).r,
            //   child: CircleAvatar(
            //     radius: 21.r,
            //     backgroundColor: const Color(0xffD9D9D9),
            //     foregroundColor: Colors.green,
            //     child: Icon(
            //       Icons.clear,
            //       size: 18.r,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
