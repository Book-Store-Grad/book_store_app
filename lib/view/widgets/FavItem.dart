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
  final String bookImage;
  final String price;
  const FavoriteItem({Key? key, required this.favId, required this.bookId, required this.bookName, required this.price, required this.bookImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/cover.png',
          width: 90.w,
          height: 110.h,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 30.w),
        SizedBox(
          width: 800.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                navigateTo(context,GBookPage(bookId:bookId) );
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  bookName,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                price,
                style: TextStyle(
                  fontSize: 18.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            BlocProvider.of<CustomerCubit>(context, listen: false)
                .removeFromFav(favId: favId);
          },
          borderRadius: BorderRadius.circular(50).r,
          child: CircleAvatar(
            radius: 21.r,
            backgroundColor: const Color(0xffD9D9D9),
            foregroundColor: Colors.green,
            child: Icon(
              CupertinoIcons.xmark,
              size: 18.r,
            ),
          ),
        ),
      ],
    );
  }
}
