import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:superkauf/feature/discover/bloc/discover_bloc.dart';
import 'package:superkauf/generic/post/model/models/get_personal_post_response.dart';

part 'discover_state.freezed.dart';

@freezed
abstract class DiscoverState with _$DiscoverState {
  const factory DiscoverState.loading() = Loading;

  const factory DiscoverState.loaded(
    List<FullContextPostModel> posts,
    bool isLoading,
    bool canLoadMore,
    SortType sortType,
    TimeRange timeRange,
  ) = Loaded;

  const factory DiscoverState.error(String error) = Error;
}
