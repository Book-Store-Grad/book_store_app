import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/Const/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AuthorBook extends StatelessWidget {

  final int bookId;
  final double price;
  final String bookImageUrl;
  final String bookName;
  const AuthorBook({Key? key, required this.bookId, required this.price, required this.bookImageUrl, required this.bookName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // navigateTo(context, )
      },
      child: Column(
        children: [
          Image.network(
            ApiUrl.base + bookImageUrl,
            width: 130.w,
            height: 150.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset("assets/images/cover.png",
                  width: 130.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            bookName,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
           '$price',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red
            ),
          )

        ],
      ),
    );
  }
}
