import 'dart:async';
import 'dart:ffi';

import 'package:mvvm_udemy/domain/model/models.dart';
import 'package:mvvm_udemy/domain/usecase/home_usecase.dart';
import 'package:mvvm_udemy/presentation/base/baseviewmodel.dart';
import 'package:mvvm_udemy/presentation/main/pages/home/viewmodel/data_list.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final _dataStreamController = BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // --  inputs
  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
      inputState.add(LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState));
      await Future.delayed(Duration(seconds: 2));
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(
          Stores,
          ServiceList,
          BannerAdList));
//to mack api
  /*    (await _homeUseCase.execute(Void)).fold(
              (failure) => {
            // left -> failure
            inputState.add(ErrorState(
                StateRendererType.fullScreenErrorState, failure.message))
          }, (homeObject) {

        inputState.add(ContentState());
        inputHomeData.add(HomeViewObject(homeObject.data.stores,
            homeObject.data.services, homeObject.data.banners));
        // navigate to main screen
      });*/




  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // -- outputs
  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
