import 'package:book_store/helper/shared_prefrences/cache_helper.dart';

String? token = CacheHelper.getData(key: 'token');
String? role =CacheHelper.getData(key: 'role');