import 'package:book_store/Const/API/Url.dart';
import 'package:book_store/Const/const.dart';
import 'package:book_store/helper/dio_helper/dio_helper.dart';
import 'package:book_store/helper/shared_prefrences/cache_helper.dart';
import 'package:book_store/model/cart.dart';
import 'package:book_store/model/favourite.dart';
import 'package:book_store/model/recommendation.dart';
import 'package:book_store/model/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/books_model.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial());

  static CustomerCubit get(context) => BlocProvider.of(context);

  Recommendation? recommendation;
  int favIndex = 0;
  int cartIndex = 0;

  void getRecommendation() async {
    emit(GetRecommendationLoading());
    DioHelper.getData(
      url: ApiUrl.recommendation,
      token: token,
      query: {'book_id': (CacheHelper.getData(key: 'currentBookId')) ?? 1},
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
  Future<void> getAllFavItems() async {
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
        print(value.data);
        print("add to Fav done");
      }
      emit(AddToFavouriteSuccess());
    }).catchError((e) {
      emit(AddToFavouriteError());
      print(e.toString());
    });
  }

  Future<void> removeFromFav({required int favId, required int index}) async {
    emit(RemoveFromFavouriteLoading());
    try {
      favIndex = index;
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

  List<CartItems> cartItems = [];

  ///Cart
  void getAllCartItems() async {
    emit(GetAllCartLoading());
    DioHelper.getData(
      url: '${ApiUrl.cart}/all',
      token: token,
    ).then((value) {
      if (value.statusCode == 200) {
        print('Get Carts Success: ${value.data}');
        cartItems.clear();
        value.data['content']['cart_items'].forEach(
          (e) => cartItems.add(CartItems.fromJson(e)),
        );
      }
      emit(GetAllCartSuccess());
    }).catchError((e) {
      emit(GetAllCartError());
      print(e.toString());
    });
  }

  Future<void> addToCart({
    required int bookId,
  }) async {
    emit(AddToCartLoading());
    DioHelper.postData(
        url: ApiUrl.cart,
        token: token,
        data: {"book_id": bookId}).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        print("add to Cart done");
      }
      emit(AddToCartSuccess());
    }).catchError((e) {
      emit(AddToCartError());
      print(e.toString());
    });
  }

  Future<void> removeFromCart({required int cartId, required int index}) async {
    emit(RemoveFromCartLoading());
    try {
      cartIndex = index;
      DioHelper.deleteData(
        url: '${ApiUrl.cart}/$cartId',
        token: token,
      ).then((value) {
        if (value.statusCode == 200) {
          cartItems.removeWhere((element) => element.caiId == cartId);
          emit(RemoveFromCartSuccess());
        }
      });
    } catch (e) {
      emit(RemoveFromFavouriteError());
      print(e.toString());
    }
  }

  BooksModel? booksModel;

  void getCategoryBooks({required String category}) {
    emit(GetCategoryBooksLoading());
    DioHelper.getData(
      url: '${ApiUrl.book}/all',
      token: token,
      query: {'category': category},
    ).then((value) {
      if (value.statusCode == 200) {
        booksModel = BooksModel.fromJson(value.data);
        print('Category Books get Successfully');
        print(value.data);
      }
      emit(GetCategoryBooksSuccess());
    }).catchError((e) {
      emit(GetCategoryBooksError());
      print(e.toString());
    });
  }

  /// search
  List<Books> searchList = [];

  void searchBook({required String searchKey}) {
    emit(SearchBookLoading());
    DioHelper.getData(
        url: ApiUrl.search,
        token: token,
        query: {'query': searchKey}).then((value) {
      if (value.statusCode == 200) {
        print('This before: ${value.data}');
        booksModel = BooksModel.fromJson(value.data);
        searchList = booksModel!.content!.books!;
        print('This after : ${value.data}');
        print('Search Result Get Done');
      }
      emit(SearchBookSuccess());
    }).catchError((onError) {
      emit(SearchBookError());
      print(onError.toString());
    });
  }

  ///order
  void addorder({required Function() onSuccess}) {
    emit(OrderLoading());
    DioHelper.postData(url: ApiUrl.order, token: token).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        onSuccess();
        print('Placed order Successfully!');
      }
      emit(OrderSuccess());
    }).catchError((onError) {
      emit(OrderError());
      print(onError.toString());
    });
  }
}
