import 'package:book_store/Const/component/component.dart';
import 'package:book_store/controller/Cubit/Customer/customer_cubit.dart';
import 'package:book_store/view/widgets/categriesItem.dart';
import 'package:book_store/view/widgets/recommendBookItem.dart';
import 'package:book_store/view/widgets/recommendation_page.dart';
import 'package:book_store/view/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CusHome extends StatelessWidget {
  const CusHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<String> categoryNames = [
      'Business',
      'Classic',
      'Technology',
      'Fiction',
      'History',
      'Education',
      'Entertainment',
      'Science',
      'Political'
    ];
    const List<Color> colors = [
      Color(0xff8d7069),
      Color(0xff3A9B7A),
      Color(0xffFE6E4C),
      Color(0xffFFC120),
      Color(0xff9B81E5),
      Color(0xff273B4A),
      Color(0xffE981DE),
      Color(0xff158CBE),
      Color(0xff0e0e0d),
    ];
    const List<IconData> categoryIcons = [
      Icons.book,
      Icons.book,
      Icons.book,
      Icons.book,
      Icons.book,
      Icons.book,
      Icons.book,
      Icons.book,
      Icons.book,
    ];
    final TextEditingController searchController = TextEditingController();
    return BlocProvider(
      create: (context) => CustomerCubit()..getRecommendation(),
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
                SearchBar(
                    screenCtx: context, searchController: searchController),
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
                          onPressed: () {
                            navigateTo(
                                context,
                                RecommendationPage(
                                    recommendation: cubit.recommendation!));
                          },
                          child: const Text(
                            'See all',
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ),
                state is GetRecommendationLoading
                    ? Column(
                        children: const [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 80),
                              child: CircularProgressIndicator(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      )
                    : cubit.recommendation == null
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 80.0),
                            child: Center(
                                child: Text(
                              'No Recommendations',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,fontSize: 20),
                            )),
                          )
                        : Expanded(
                            child: ListView.separated(
                                padding: const EdgeInsets.all(8.0),
                                itemBuilder: (context, index) => RecommendBook(
                                    recommendations: cubit.recommendation!
                                        .content!.recommendations![index]),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) => SizedBox(
                                      width: 10.w,
                                    ),
                                itemCount: 5),
                          ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.all(8.0),
                        itemBuilder: (context, index) => CategoriesList(
                              categoryImage: categoryIcons[index],
                              cateogryName: categoryNames[index],
                              color: colors[index],
                            ),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10.w,
                            ),
                        itemCount: 9))
              ],
            ),
          );
        },
      ),
    );
  }
}
