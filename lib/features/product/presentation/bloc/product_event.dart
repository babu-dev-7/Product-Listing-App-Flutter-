abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class ToggleFavoriteEvent extends ProductEvent {
  final int id;

  ToggleFavoriteEvent(this.id);
}

class ToggleCartEvent extends ProductEvent {
  final int id;

  ToggleCartEvent(this.id);
}