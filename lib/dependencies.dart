part of 'main.dart';

var _resolvedDependencies = <Type, dynamic>{};

void initializeDependencies() {
  register<AddressRepository>(MockedAddressRepository());
  register<CreditCardRepository>(MockedCreditCardRepository());
  register<PlanRepository>(MockedPlanRepository());
  register<ProductRepository>(MockedProductRepository());
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
