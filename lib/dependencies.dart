part of 'main.dart';

var _resolvedDependencies = <Type, dynamic>{};

void initializeDependencies() {
  register<AddressRepository>(RestAddressRepository());
  register<AuthenticationRepository>(RestAuthenticationRepository());
  register<CreditCardRepository>(RestCreditCardRepository());
  register<PlanRepository>(RestPlanRepository());
  register<ProductRepository>(RestProductRepository());
  register<OrderRepository>(MockedOrderRepository());
  register<BannerRepository>(MockedBannerRepository());
}

void register<T>(T instance) {
  _resolvedDependencies[T] = instance;
}

T resolve<T>() {
  var resolved = _resolvedDependencies[T];

  if (resolved == null) {
    throw ArgumentError('Dependency not found: $T');
  }

  if (resolved is! T) {
    throw ArgumentError('Resolved dependency is not of type $T');
  }

  return resolved;
}
