abstract class NewsStates  {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavigation extends NewsStates {}

class ChangeColorMode extends NewsStates{
  final bool mode ;
  ChangeColorMode({this.mode});
}

class NewsBusinessLoadingState extends NewsStates {}
class NewsBusinessSuccessState extends NewsStates {}
class NewsBusinessErrorState extends NewsStates {
  String error ;
  NewsBusinessErrorState({this.error});
}

class NewsSportsLoadingState extends NewsStates {}
class NewsSportsSuccessState extends NewsStates {}
class NewsSportsErrorState extends NewsStates {
  String error ;
  NewsSportsErrorState({this.error});
}

class NewsScienceLoadingState extends NewsStates {}
class NewsScienceSuccessState extends NewsStates {}
class NewsScienceErrorState extends NewsStates {
  String error ;
  NewsScienceErrorState({this.error});
}


class SearchNewsLoadingState extends NewsStates{}
class SearchNewsSuccessState extends NewsStates{
  final List<dynamic> news ;
  SearchNewsSuccessState({this.news});
}
class SearchNewsErrorState extends NewsStates {
  String error ;
  SearchNewsErrorState({this.error});
}