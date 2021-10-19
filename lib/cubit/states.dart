import 'package:shop_app/model/address_model/add_address.dart';
import 'package:shop_app/model/cart_model/add_cart.dart';
import 'package:shop_app/model/favorites_model/change_favorite.dart';
import 'package:shop_app/model/profile_model/user.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ChangeSuffixState extends ShopStates {}

class ChangeBottomNavState extends ShopStates {}

/// state home
class HomeLoadingState extends ShopStates {}

class HomeSuccessState extends ShopStates {}

class HomeErrorState extends ShopStates {}

/// end state home

/// state categories
class CategoriesLoadingState extends ShopStates {}

class CategoriesSuccessState extends ShopStates {}

class CategoriesErrorState extends ShopStates {}

/// end state categories

/// state categories details
class CategoriesDetailsLoadingState extends ShopStates {}

class CategoriesDetailsSuccessState extends ShopStates {}

class CategoriesDetailsErrorState extends ShopStates {}

/// end state Categories Details

/// state Product Details
class ProductDetailsLoadingState extends ShopStates {}

class ProductDetailsSuccessState extends ShopStates {}

class ProductDetailsErrorState extends ShopStates {}

/// end state Product Details

/// state  Change Favorite
class ChangeFavoriteLoadingState extends ShopStates {}

class ChangeFavoritesManuallySuccessState extends ShopStates {}

class ChangeFavoriteSuccessState extends ShopStates {
  final ChangeToFavoritesModel model;

  ChangeFavoriteSuccessState(this.model);
}

class ChangeFavoriteErrorState extends ShopStates {}

/// end state  Change Favorite

/// state Favorites
class FavoritesLoadingState extends ShopStates {}

class FavoritesSuccessState extends ShopStates {}

class FavoritesErrorState extends ShopStates {}

/// end state  Favorites
/// state Add Address
class AddAddressLoadingState extends ShopStates {}

class AddAddressSuccessState extends ShopStates {
  final AddAddressModel addAddressModel;

  AddAddressSuccessState(this.addAddressModel);
}

class AddAddressErrorState extends ShopStates {}

/// end state Add Address

/// state  Addresses
class AddressesLoadingState extends ShopStates {}

class AddressesSuccessState extends ShopStates {}

class AddressesErrorState extends ShopStates {}

/// end state  Addresses

/// state Update Address
class UpdateAddressLoadingState extends ShopStates {}

class UpdateAddressSuccessState extends ShopStates {}

class UpdateAddressErrorState extends ShopStates {}

/// end state Update Address

/// state Delete Address
class DeleteAddressLoadingState extends ShopStates {}

class DeleteAddressSuccessState extends ShopStates {}

class DeleteAddressErrorState extends ShopStates {}

/// end state Delete Address

/// state  FAQs
class FAQsLoadingState extends ShopStates {}

class FAQsSuccessState extends ShopStates {}

class FAQsErrorState extends ShopStates {}

/// end state FAQs

/// state Profile
class ProfileLoadingState extends ShopStates {}

class ProfileSuccessState extends ShopStates {}

class ProfileErrorState extends ShopStates {}

/// end state Profile
/// state Update Profile
class UpdateProfileLoadingState extends ShopStates {}

class UpdateProfileSuccessState extends ShopStates {
  final UserModel updateUserModel;

  UpdateProfileSuccessState(this.updateUserModel);
}

class UpdateProfileErrorState extends ShopStates {}

/// end state  Update Profile
/// state ChangePass
class ChangePassLoadingState extends ShopStates {}

class ChangePassSuccessState extends ShopStates {
  final UserModel userModel;

  ChangePassSuccessState(this.userModel);
}

class ChangePassErrorState extends ShopStates {}

/// end state ChangePass
/// state  Add Cart
class AddCartLoadingState extends ShopStates {}

class AddCartSuccessState extends ShopStates {
  final AddCartModel addCartModel;

  AddCartSuccessState(this.addCartModel);
}

class AddCartErrorState extends ShopStates {}

/// end state  Add Cart
/// state Update Cart
class UpdateCartLoadingState extends ShopStates {}

class UpdateCartSuccessState extends ShopStates {}

class UpdateCartErrorState extends ShopStates {}

/// end state Update Cart
/// state Cart
class CartLoadingState extends ShopStates {}

class CartSuccessState extends ShopStates {}

class CartErrorState extends ShopStates {}

/// end state Cart
