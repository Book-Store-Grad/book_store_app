import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;

  const SearchBar({Key? key, required this.searchController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
          filled: true,
          fillColor: Colors.black12,
          hintText: 'Search Book Here....',
          hintStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff777777),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15).r,
            borderSide: BorderSide.none,

          ),
          constraints: BoxConstraints(
            maxWidth: 800.w,
            maxHeight: 50.h,
          ),
          isDense: true,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              size: 18.r,
              color: const Color(0xff1a1a1a),
            ),
            onPressed: () {
              // BlocProvider.of<HomeCubit>(context).searchBook();
            },
            hoverColor: Colors.transparent,
          ),
        ),
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        onTap: () {},
      ),
    );
  }
}
