part of 'customer_cubit.dart';

abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

///Recommendation
class GetRecommendationLoading extends CustomerState {}

class GetRecommendationSuccess extends CustomerState {}

class GetRecommendationError extends CustomerState {}

///Favourite
class GetAllFavouriteLoading extends CustomerState {}

class GetAllFavouriteSuccess extends CustomerState {}

class GetAllFavouriteError extends CustomerState {}

class AddToFavouriteLoading extends CustomerState {}

class AddToFavouriteSuccess extends CustomerState {}

class AddToFavouriteError extends CustomerState {}

class RemoveFromFavouriteLoading extends CustomerState {}

class RemoveFromFavouriteSuccess extends CustomerState {}

class RemoveFromFavouriteError extends CustomerState {}

class FavouriteRefresh extends CustomerState {}

///Category
class GetCategoryBooksLoading extends CustomerState {}

class GetCategoryBooksSuccess extends CustomerState {}

class GetCategoryBooksError extends CustomerState {}

///Cart
class GetAllCartLoading extends CustomerState {}

class GetAllCartSuccess extends CustomerState {}

class GetAllCartError extends CustomerState {}

class AddToCartLoading extends CustomerState {}

class AddToCartSuccess extends CustomerState {}

class AddToCartError extends CustomerState {}

class RemoveFromCartLoading extends CustomerState {}

class RemoveFromCartSuccess extends CustomerState {}

class RemoveFromCartError extends CustomerState {}

///Search

class SearchBookLoading extends CustomerState {}

class SearchBookSuccess extends CustomerState {}

class SearchBookError extends CustomerState {}
