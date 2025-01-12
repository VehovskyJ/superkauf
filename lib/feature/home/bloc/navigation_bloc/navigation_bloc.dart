import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:superkauf/generic/constants.dart';
import 'package:superkauf/library/app_navigation.dart';

import 'navigation_state.dart';

part 'navigation_event.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationStateLoaded(bottomNavIndex: 0, screenName: ScreenPath.feedScreen)) {
    on<OpenStoresScreen>(_onOpenStoresScreen);
    on<OpenDiscoverScreen>(_onOpenDiscoverScreen);
    on<OpenSettingsScreen>(_onOpenSettingsScreen);
    on<OpenFeedScreen>(_onOpenFeedScreen);
    on<OpenProfileScreen>(_onOpenProfileScreen);
    on<OpenShoppingListScreen>(_onOpenShoppingListScreen);
    on<GoToCreatePostScreen>(_onGoToCreatePostScreen);
    on<OpenPostDetailScreen>(_onOpenPostDetailScreen);
    on<OpenUserDetailScreen>(_onOpenUserDetailScreen);
    on<OpenMyNotificationsScreen>(_onOpenMyNotificationsScreen);
    on<OpenSearchScreen>(_onOpenSearchScreen);
  }

  var bottomBarIndex = 0;

  Future<void> _onOpenStoresScreen(
    OpenStoresScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 1;
    emit(NavigationStateLoaded(
      bottomNavIndex: event.index != null ? event.index! : bottomBarIndex,
      screenName: ScreenPath.storesScreen,
      params: event.storeId,
    ));

    Posthog().screen(
      screenName: ScreenPath.storesScreen,
    );
  }

  Future<void> _onOpenDiscoverScreen(
    OpenDiscoverScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 2;
    emit(NavigationStateLoaded(bottomNavIndex: event.index != null ? event.index! : bottomBarIndex, screenName: ScreenPath.discoverScreen));

    Posthog().screen(
      screenName: ScreenPath.discoverScreen,
    );
  }

  Future<void> _onOpenSearchScreen(
    OpenSearchScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 3;
    emit(NavigationStateLoaded(bottomNavIndex: event.index != null ? event.index! : bottomBarIndex, screenName: ScreenPath.searchScreen));

    Posthog().screen(
      screenName: ScreenPath.searchScreen,
    );
  }

  Future<void> _onOpenSettingsScreen(
    OpenSettingsScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 3;
    AppNavigation().push(ScreenPath.settingsScreen);

    Posthog().screen(
      screenName: ScreenPath.settingsScreen,
    );
  }

  Future<void> _onOpenFeedScreen(
    OpenFeedScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 0;
    emit(NavigationStateLoaded(bottomNavIndex: event.index != null ? event.index! : bottomBarIndex, screenName: ScreenPath.feedScreen));

    Posthog().screen(
      screenName: ScreenPath.feedScreen,
    );
  }

  Future<void> _onOpenProfileScreen(
    OpenProfileScreen event,
    Emitter<NavigationState> emit,
  ) async {
    AppNavigation().push(ScreenPath.profileScreen, replace: event.shouldReplace ? 1 : 0);

    Posthog().screen(
      screenName: ScreenPath.profileScreen,
    );
  }

  Future<void> _onOpenShoppingListScreen(
    OpenShoppingListScreen event,
    Emitter<NavigationState> emit,
  ) async {
    bottomBarIndex = 4;
    emit(NavigationStateLoaded(bottomNavIndex: event.index != null ? event.index! : bottomBarIndex, screenName: ScreenPath.shoppingListScreen));

    Posthog().screen(
      screenName: ScreenPath.shoppingListScreen,
    );
  }

  Future<void> _onGoToCreatePostScreen(
    GoToCreatePostScreen event,
    Emitter<NavigationState> emit,
  ) async {
    // emit(NavigationStateLoaded(bottomNavIndex: event.index != null ? event.index! : bottomBarIndex, screenName: ScreenPath.createPostScreen));
    AppNavigation().push(ScreenPath.createPostScreen);

    Posthog().screen(
      screenName: ScreenPath.createPostScreen,
    );
  }

  Future<void> _onOpenPostDetailScreen(
    OpenPostDetailScreen event,
    Emitter<NavigationState> emit,
  ) async {
    AppNavigation().push(ScreenPath.postDetailScreen, replace: event.shouldReplace ? 1 : 0);

    Posthog().screen(
      screenName: ScreenPath.postDetailScreen,
      properties: {
        'post_id': event.postId,
      },
    );
  }

  Future<void> _onOpenUserDetailScreen(
    OpenUserDetailScreen event,
    Emitter<NavigationState> emit,
  ) async {
    AppNavigation().push(ScreenPath.userDetailScreen);

    Posthog().screen(
      screenName: ScreenPath.userDetailScreen,
    );
  }

  Future<void> _onOpenMyNotificationsScreen(
    OpenMyNotificationsScreen event,
    Emitter<NavigationState> emit,
  ) async {
    AppNavigation().push(ScreenPath.myNotificationsScreen);

    Posthog().screen(
      screenName: ScreenPath.myNotificationsScreen,
    );
  }
}
