import 'package:book_store/view/widgets/recommendBookItem.dart';
import 'package:flutter/material.dart';

import '../../model/recommendation.dart';

class RecommendationPage extends StatelessWidget {
  final Recommendation recommendation;

  const RecommendationPage({Key? key, required this.recommendation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Text(
            'Book Recommendation',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.only(top: 20),
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.2,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                    recommendation.content!
                        .recommendations!.length,
                        (index) =>
                        RecommendBook(recommendations: recommendation.content
                        !.recommendations![index],
                        )),
              ),
            )
          ],
        ),
    );
  }
}
