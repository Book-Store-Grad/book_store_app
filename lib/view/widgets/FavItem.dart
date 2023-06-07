import 'package:book_store/Const/component/component.dart';
import 'package:book_store/Const/const.dart';
import 'package:book_store/view/widgets/book_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Const/API/Url.dart';
class FavoriteItem extends StatelessWidget {

  final int bookId;
  final String bookName;
  final String bookImage;
  final String price;
   FavoriteItem({Key? key, required this.bookId, required this.bookName, required this.price, required this.bookImage}) : super(key: key);

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
            Image.network(
              ApiUrl.photoBase+ bookName,
              headers: {
                'Authorization': 'Bearer $token}'
              },
              width: 90.w,
              height: 110.h,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    "assets/images/cover.png",
                    width: 90.w,
                    height: 110.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
          ],
        ),
      ),
    );
  }
}
