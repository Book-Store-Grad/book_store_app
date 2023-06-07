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
