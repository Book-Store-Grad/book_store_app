import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/Const/component/component.dart';
import 'package:book_store/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store/model/books_model.dart';
import 'package:book_store/view/widgets/book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthorBook extends StatelessWidget {
  final Books book;

  const AuthorBook({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CacheHelper.saveData(key: 'currentBookId', value: book.bId);
        print('This is Recommend Book ID: ${book.bId}');
        replaceTo(context, GBookPage(bookId: book.bId!));
      },
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              ApiUrl.photoBase + book.coverImageUrl!,
              headers: {
                'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
              },
              width: 130.w,
              height: 150.h,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    "assets/images/cover.png",
                    width: 130.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            book.bName!,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${book.bPrice}',
            style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red),
          )
        ],
      ),
    );
  }
}
