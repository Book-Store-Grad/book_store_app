import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:book_store/view/widgets/SearchItems.dart';
import 'package:book_store/view/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return BlocProvider(
      create: (context) => CustomerCubit(),
      child: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {},
        builder: (context, state) {
          CustomerCubit cubit = CustomerCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: const Text(
                'Search Result',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                SearchBar(screenCtx: context,searchController: searchController,searchScreen: true),
                state is SearchBookLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
                    :cubit.booksModel !=null && cubit.searchList.isEmpty ?Center(
                  child: Text(
                    'No Result Found!',
                    style: GoogleFonts.akayaKanadaka(
                        fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ): Expanded(
                      child: GridView.count(
                        padding: EdgeInsets.only(top: 20),
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.2,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: List.generate(
                            cubit.searchList.length,
                                (index) => SearchItems(
                              books: cubit.searchList[index],
                            )),
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
