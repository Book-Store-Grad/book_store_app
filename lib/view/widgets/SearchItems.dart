import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/Const/component/component.dart';
import 'package:book_store/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store/model/books_model.dart';
import 'package:book_store/view/widgets/book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SearchItems extends StatelessWidget {
  const SearchItems({Key? key, required this.books}) : super(key: key);
final Books books;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CacheHelper.saveData(key: 'currentBookId', value: books.bId);
        print('This is Recommend Book ID${books.bId}');
          replaceTo(context, GBookPage(bookId: books.bId!));
      },
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              ApiUrl.photoBase + books.coverImageUrl!,
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
            books.bName!,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${books.bPrice}',
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
