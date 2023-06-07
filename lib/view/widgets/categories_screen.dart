import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:book_store/view/widgets/bookItem.dart';
import 'package:book_store/view/widgets/categriesItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CustomerCubit()..getCategoryBooks(category: category),
      child: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {},
        builder: (context, state) {
          CustomerCubit cubit = CustomerCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: Text(
                category,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              centerTitle: true,
            ),
            body:
            cubit.booksModel == null
                ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
                : cubit.booksModel!.content!.books!.isEmpty
                ? Center(
              child: Text(
                'No Book Here....!',
                style: GoogleFonts.akayaKanadaka(
                    fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            )
                :Column(
              children: [
                Expanded(
                  child: GridView.count(
                    padding: EdgeInsets.only(top: 20),
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.2,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: List.generate(
                        cubit.booksModel!.content!.books!.length,
                        (index) => AuthorBook(
                              book: cubit.booksModel!.content!.books![index],
                            )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
