import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/search/states.dart';
import 'package:shop_app/model/search_model/search.dart';
import 'package:shop_app/remote_network/dio_helper.dart';
import 'package:shop_app/remote_network/end_point.dart';
import 'package:shop_app/shared/constant.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void getSearchData(String searchText){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':searchText,
        }
    ).then((value){
      searchModel = SearchModel.fromJson(value.data);
      print('Search '+searchModel!.status.toString());
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}