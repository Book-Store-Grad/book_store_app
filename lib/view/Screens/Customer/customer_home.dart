import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:book_store/view/widgets/recommendBookItem.dart';
import 'package:book_store/view/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CusHome extends StatelessWidget {
  const CusHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return BlocProvider(
      create: (context) => CustomerCubit()..getRecommendation(currentBookId: 1),
      child: BlocConsumer<CustomerCubit, CustomerState>(
        listener: (context, state) {},
        builder: (context, state) {
          CustomerCubit cubit = CustomerCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              centerTitle: true,
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            body: Column(
              children: [
                SearchBar(searchController: searchController),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recommendation',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            'See all',
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ),
                state is GetRecommendationLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(8.0),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                 RecommendBook(recommendations: cubit.recommendation!.content!.recommendations![index]),
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 10.w,
                                ),
                            itemCount: cubit.recommendation!.content!
                                .recommendations!.length),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
