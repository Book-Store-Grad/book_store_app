import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/Const/const.dart';
import 'package:book_store/helper/dio_helper/dio_helper.dart';
import 'package:book_store/model/favourite.dart';
import 'package:book_store/model/recommendation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial());

  static CustomerCubit get(context) => BlocProvider.of(context);

  Recommendation? recommendation;

  void getRecommendation({required int currentBookId}) async {
    emit(GetRecommendationLoading());
    DioHelper.getData(
      url: ApiUrl.recommendation,
      token: token,
      query: {'book_id': 1},
    ).then((value) {
      if (value.statusCode == 200) {
        recommendation = Recommendation.fromJson(value.data);
        print('Recommendation Books get Successfully');
        print(value.data);
      }
      emit(GetRecommendationSuccess());
    }).catchError((e) {
      emit(GetRecommendationError());
      print(e.toString());
    });
  }

  List<Favorites> favItems = [];

  ///Favourite
  void getAllFavItems() async {
    emit(GetAllFavouriteLoading());
    DioHelper.getData(
      url: '${ApiUrl.favorite}/all',
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        print('Get Favourites Success: ${value.data}');

        favItems.clear();
        value.data['content']['favorites'].forEach(
          (e) => favItems.add(Favorites.fromJson(e)),
        );
        for (var favId in favItems) {
          print("This is fav ID: $favId.favId");
        }
      }
      emit(GetAllFavouriteSuccess());
    }).catchError((e) {
      emit(GetAllFavouriteError());
      print(e.toString());
    });
  }

  Future<void> addToFavourite({
    required int bookId,
  }) async {
    emit(AddToFavouriteLoading());
    DioHelper.postData(
        url: ApiUrl.favorite,
        token: token,
        data: {"book_id": bookId}).then((value) {
      if (value.statusCode == 200) {
        print("add to Fav done");
      }
      emit(AddToFavouriteSuccess());
    }).catchError((e) {
      emit(AddToFavouriteError());
      print(e.toString());
    });
  }

  Future<void> removeFromFav({
    required int favId,
  }) async {
    emit(RemoveFromFavouriteLoading());
    try {
      DioHelper.deleteData(
        url: '${ApiUrl.favorite}/$favId',
        token: token,
      ).then((value) {
        if (value.statusCode == 200) {
          favItems.removeWhere((element) => element.faId == favId);
          emit(RemoveFromFavouriteSuccess());
        }
      });
    } catch (e) {
      emit(RemoveFromFavouriteError());
      print(e.toString());
    }
  }
}
