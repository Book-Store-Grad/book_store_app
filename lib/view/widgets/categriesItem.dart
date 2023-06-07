import 'package:book_store/Const/component/component.dart';
import 'package:book_store/view/widgets/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesList extends StatelessWidget {
  final IconData categoryImage;
  final String cateogryName;
  final Color color;

  const CategoriesList(
      {Key? key,
      required this.categoryImage,
      required this.cateogryName,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          navigateTo(
              context,
              CategoryScreen(
                category: cateogryName,
              ));
        },
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: color),
              width: 120.w,
              height: 120.w,
              child: Icon(categoryImage, size: 60, color: Colors.white),
            ),
            SizedBox(height: 5.h),
            Text(
              cateogryName,
              style: TextStyle(fontSize: 20.sp, color: Colors.grey),
            ),
          ],
        ));
  }
}
