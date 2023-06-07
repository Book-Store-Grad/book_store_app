import 'package:book_store/Const/component/component.dart';
import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:book_store/view/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;

  const SearchBar({Key? key, required this.searchController,  this.searchScreen =false, required this.screenCtx}) : super(key: key);

 final bool searchScreen ;
 final BuildContext screenCtx;
 static FocusNode searchFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerCubit(),
      child: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {},
        builder: (context, state) {
          CustomerCubit cubit = CustomerCubit.get(screenCtx);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
focusNode: searchFocusNode,
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
                suffixIcon: Icon(
                  Icons.search,
                  size: 18.r,
                  color: const Color(0xff1a1a1a),
                ),
              ),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              onTap: () {
                if(!searchScreen){
                navigateTo(context, const ResultScreen());
                }
              },
              onSubmitted: (v) {
                cubit.searchBook(searchKey: v);
              },
              readOnly: !searchScreen,
            ),
          );
        },
      ),
    );
  }
}
