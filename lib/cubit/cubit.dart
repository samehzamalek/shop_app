import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/model/address_model/add_address.dart';
import 'package:shop_app/model/address_model/address.dart';
import 'package:shop_app/model/address_model/update_and_delete_address.dart';
import 'package:shop_app/model/cart_model/add_cart.dart';
import 'package:shop_app/model/cart_model/cart.dart';
import 'package:shop_app/model/cart_model/update_cart.dart';
import 'package:shop_app/model/categories_model/categories.dart';
import 'package:shop_app/model/categories_model/categories_details.dart';
import 'package:shop_app/model/favorites_model/change_favorite.dart';
import 'package:shop_app/model/favorites_model/favorites.dart';
import 'package:shop_app/model/home_model/home.dart';
import 'package:shop_app/model/home_model/product.dart';
import 'package:shop_app/model/profile_model/faqs.dart';
import 'package:shop_app/model/profile_model/user.dart';
import 'package:shop_app/modules/account.dart';
import 'package:shop_app/modules/cart.dart';
import 'package:shop_app/modules/categories.dart';
import 'package:shop_app/modules/home.dart';
import 'package:shop_app/remote_network/dio_helper.dart';
import 'package:shop_app/remote_network/end_point.dart';
import 'package:shop_app/shared/constant.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  Map <dynamic ,dynamic> favorites = {};
  Map <dynamic ,dynamic> cart = {};
  bool showCurrentPassword = false;
  IconData currentPasswordIcon = Icons.visibility;
  void changeCurrentPassIcon(context){
    showCurrentPassword =! showCurrentPassword;
    if(showCurrentPassword)
      currentPasswordIcon = Icons.visibility_off;
    else
      currentPasswordIcon = Icons.visibility;
    emit(ChangeSuffixState());
  }

  bool showNewPassword = false;
  IconData newPasswordIcon = Icons.visibility;
  void changeNewPassIcon(context){
    showNewPassword =! showNewPassword;
    if(showNewPassword)
      newPasswordIcon = Icons.visibility_off;
    else
      newPasswordIcon = Icons.visibility;
    emit(ChangeSuffixState());
  }
  List<Widget> screens = [
      HomeScreen(),
    const CategoriesScreen(),
    const AccountScreen(),
      CartScreen(),
  ];
  Icon favoriteIcon =const Icon (Icons.favorite,color: Colors.blue,);
  Icon unFavoriteIcon =const Icon (Icons.favorite_border_rounded);
  List<BottomNavigationBarItem> navBar =
  [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.grid_view),
      label: 'Categories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'My Account',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_outlined),
      label: 'Cart',
    ),
  ];
  int currentIndex = 0;

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  /// get home
  HomeModel? homeModel;

  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print('Home '+homeModel!.status.toString());
      homeModel!.data!.products.forEach((element)
      {
        favorites.addAll({
          element.id : element.inFavorites
        });
      });
      emit(HomeSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(HomeErrorState());
    });
  }
  CategoriesModel? categoriesModel;
  void getCategories(){
    emit(CategoriesLoadingState());
    DioHelper.getData(
        url: CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(CategoriesSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoriesErrorState());
    });
  }
  CategoryDetailModel? categoryDetailModel;
  void getCategoryDetailData(int? id){
    emit(CategoriesDetailsLoadingState());
    DioHelper.getData(
      url: CATEGORIES_DETAIL,
    token: token
    ).then((value) {
      categoryDetailModel=CategoryDetailModel.fromJson(value.data);
      emit(CategoriesDetailsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(CategoriesDetailsErrorState());

    });
  }
  ProductDetailsModel? productDetailsModel;
  void getProductData( productId ) {
    productDetailsModel = null;
    emit(ProductDetailsLoadingState());
    DioHelper.getData(
        url: 'products/$productId',
        token: token
    ).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print('Product Detail '+productDetailsModel!.status.toString());
      emit(ProductDetailsSuccessState());
    }).catchError((error){
      emit(ProductDetailsErrorState());
      print(error.toString());
    });
  }

  FavoritesModel ? favoritesModel;
  void getFavoriteData() {
    emit(FavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value.data);
      print('Favorites '+favoritesModel!.status.toString());
      emit(FavoritesSuccessState());
    }).catchError((error){
      emit(FavoritesErrorState());
      print(error.toString());
    });
  }


  ChangeToFavoritesModel ?changeToFavoritesModel;
  void changeToFavorite(int? productID) {
    favorites[productID] = !favorites[productID];
    emit(ChangeFavoritesManuallySuccessState());

    emit(ChangeFavoriteLoadingState());
    DioHelper.postData(
        url: FAVORITES,
        token: token,
        data: {
          'product_id': productID
        }
    ).then((value){
      changeToFavoritesModel = ChangeToFavoritesModel.fromJson(value.data);
      print(changeToFavoritesModel!.status);
      if(changeToFavoritesModel!.status == false) {
        favorites[productID] = !favorites[productID];
      } else {
        getFavoriteData();
      }
      emit(ChangeFavoriteSuccessState(changeToFavoritesModel!));
    }).catchError((error){
      favorites[productID] = !favorites[productID];
      emit(ChangeFavoriteErrorState());
      print(error.toString());
    });
  }
  AddAddressModel? addAddressModel;
  void addAddress({
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }){
    emit(AddAddressLoadingState());
    DioHelper.postData(
        url: 'addresses',
        token: token,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'notes': notes,
          'latitude': latitude,
          'longitude': longitude,
        }
    ).then((value){
      addAddressModel = AddAddressModel.fromJson(value.data);
      print('Add Address '+ addAddressModel!.status.toString());
      if(addAddressModel!.status) {
        getAddresses();
      } else {
        showToast( state: ToastStates.SUCCESS,msg:addAddressModel!.message,);
      }
      emit(AddAddressSuccessState(addAddressModel!));
    }).catchError((error){
      emit(AddAddressErrorState());
      print(error.toString());
    });
  }

    late AddressModel addressModel;
  void getAddresses() {
    emit(AddressesLoadingState());
    DioHelper.getData(
      url: 'addresses',
      token: token,
    ).then((value){
      addressModel = AddressModel.fromJson(value.data);
      print('Get Addresses '+ addressModel.status.toString());
      emit(AddressesSuccessState());
    }).catchError((error){
      emit(AddressesErrorState());
      print(error.toString());
    });
  }

  UpdateAddressModel ? updateAddressModel;
  void updateAddress({
    required int ?addressId,
    required String name,
    required String city,
    required String region,
    required String details,
    required String notes,
    double latitude = 30.0616863,
    double longitude = 31.3260088,
  }){
    emit(UpdateAddressLoadingState());
    DioHelper.postData(
        url: 'addresses/$addressId',
        token: token,
        data: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'notes': notes,
          'latitude': latitude,
          'longitude': longitude,
        }
    ).then((value){
      updateAddressModel = UpdateAddressModel.fromJson(value.data);
      print('Update Address '+ addAddressModel!.status.toString());
      if(updateAddressModel!.status) {
        getAddresses();
      }
      emit(UpdateAddressSuccessState());
    }).catchError((error){
      emit(UpdateAddressErrorState());
      print(error.toString());
    });
  }

  UpdateAddressModel ? deleteAddressModel;
  void deleteAddress({required addressId}){
    emit(DeleteAddressLoadingState());
    DioHelper.deleteData(
      url: 'addresses/$addressId',
      token: token,
    ).then((value){
      deleteAddressModel = UpdateAddressModel.fromJson(value.data);
      print('delete Address '+ deleteAddressModel!.status.toString());
      if(deleteAddressModel!.status) {
        getAddresses();
      }
      emit(DeleteAddressSuccessState());
    }).catchError((error){
      emit(DeleteAddressErrorState());
      print(error.toString());
    });
  }
/// END OF ADDRESS API
  late FAQsModel  faqsModel;
  void getFAQsData() {
    emit(FAQsLoadingState());
    DioHelper.getData(
      url: 'faqs',
    ).then((value){
      faqsModel = FAQsModel.fromJson(value.data);
      print('Get FAQs '+ faqsModel.status.toString());
      emit(FAQsSuccessState());
    }).catchError((error){
      emit(FAQsErrorState());
      print(error.toString());
    });
  }

  UserModel? userModel;
  void getProfileData() {
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value){
      userModel = UserModel.fromJson(value.data);
      print('Profile '+ userModel!.status.toString());
      print('Profile '+ userModel!.status.toString());
      print(userModel!.data!.token);
      print(userModel!.data!.name);
      emit(ProfileSuccessState());
    }).catchError((error){
      emit(ProfileErrorState());
      print(error.toString());
    });
  }

  void updateProfileData({
    required String email,
    required String name,
    required String phone,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name':name,
          'phone': phone,
          'email': email,
        }
    ).then((value){
      userModel = UserModel.fromJson(value.data);
      print('Update Profile '+ userModel!.status.toString());
      emit(UpdateProfileSuccessState(userModel!));
    }).catchError((error){
      emit(UpdateProfileErrorState());
      print(error.toString());
    });
  }

  UserModel ?passwordModel;
  void changePassword({
    required context,
    required String currentPass,
    required String newPass
  }) {
    emit(ChangePassLoadingState());
    DioHelper.postData(
        url: 'change-password',
        token: token,
        data: {
          'current_password':currentPass,
          'new_password': newPass,
        }
    ).then((value){
      passwordModel = UserModel.fromJson(value.data);
      print('Change Password '+ passwordModel!.status.toString());
      if(passwordModel!.status!) {
        showToast(state: ToastStates.SUCCESS,msg: passwordModel!.message);
        pop(context);
      } else {
        showToast(msg: passwordModel!.message,state: ToastStates.ERROR);
      }
      emit(ChangePassSuccessState(userModel!));
    }).catchError((error){
      emit(ChangePassErrorState());
      print(error.toString());
    });
  }

  /// CART API
  late AddCartModel  addCartModel;
  void addToCart(int? productID) {
    emit(AddCartLoadingState());
    DioHelper.postData(
        url: CART,
        token: token,
        data: {
          'product_id': productID
        }
    ).then((value){
      addCartModel = AddCartModel.fromJson(value.data);
      print('AddCart '+ addCartModel.status.toString());
      if(addCartModel.status) {
        getCartData();
        getHomeData();
      }
      else {
        showToast(msg: addCartModel.message,state: ToastStates.SUCCESS);
      }
      emit(AddCartSuccessState(addCartModel));
    }).catchError((error){
      emit(AddCartErrorState());
      print(error.toString());
    });
  }

  late UpdateCartModel  updateCartModel;
  void updateCartData(int? cartId,int? quantity) {
    emit(UpdateCartLoadingState());
    DioHelper.putData(
      url: 'carts/$cartId',
      data: {
        'quantity':'$quantity',
      },
      token: token,
    ).then((value){
      updateCartModel = UpdateCartModel.fromJson(value.data);
      if(updateCartModel.status)
        getCartData();
      else {
        showToast(msg: updateCartModel.message,state: ToastStates.SUCCESS);
      }
      print('Update Cart '+ updateCartModel.status.toString());
      emit(UpdateCartSuccessState());
    }).catchError((error){
      emit(UpdateCartErrorState());
      print(error.toString());
    });
  }

  late CartModel  cartModel;
  void getCartData() {
    emit(CartLoadingState());
    DioHelper.getData(
      url: CART,
      token: token,
    ).then((value){
      cartModel = CartModel.fromJson(value.data);
      cartLength = cartModel.data!.cartItems.length;
      print('Get Cart '+ cartModel.status.toString());
      emit(CartSuccessState());
    }).catchError((error){
      emit(CartErrorState());
      print(error.toString());
    });
  }
/// END OF CART API
  bool inCart = false;
}
