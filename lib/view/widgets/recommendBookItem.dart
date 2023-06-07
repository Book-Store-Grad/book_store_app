import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/Const/component/component.dart';
import 'package:book_store/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store/model/recommendation.dart';
import 'package:book_store/view/widgets/book_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendBook extends StatelessWidget {
  final Recommendations recommendations;

  const RecommendBook({Key? key, required this.recommendations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('This rec book id:${recommendations.bId}');
        replaceTo(
            context,
            GBookPage(
             bookId: recommendations.bId!,
            ));
      },
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              ApiUrl.photoBase
              //+ recommendations.coverImageUrl!
              ,
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
            recommendations!.bName!,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            recommendations!.bPrice!,
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
