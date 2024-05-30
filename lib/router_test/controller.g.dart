// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$frameControllerHash() => r'4df1ee8046cf8831dcca757dc1afaa6c763dfd3f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$FrameController
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final String frameId;

  FutureOr<void> build({
    required String frameId,
  });
}

/// See also [FrameController].
@ProviderFor(FrameController)
const frameControllerProvider = FrameControllerFamily();

/// See also [FrameController].
class FrameControllerFamily extends Family<AsyncValue<void>> {
  /// See also [FrameController].
  const FrameControllerFamily();

  /// See also [FrameController].
  FrameControllerProvider call({
    required String frameId,
  }) {
    return FrameControllerProvider(
      frameId: frameId,
    );
  }

  @override
  FrameControllerProvider getProviderOverride(
    covariant FrameControllerProvider provider,
  ) {
    return call(
      frameId: provider.frameId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'frameControllerProvider';
}

/// See also [FrameController].
class FrameControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<FrameController, void> {
  /// See also [FrameController].
  FrameControllerProvider({
    required String frameId,
  }) : this._internal(
          () => FrameController()..frameId = frameId,
          from: frameControllerProvider,
          name: r'frameControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$frameControllerHash,
          dependencies: FrameControllerFamily._dependencies,
          allTransitiveDependencies:
              FrameControllerFamily._allTransitiveDependencies,
          frameId: frameId,
        );

  FrameControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.frameId,
  }) : super.internal();

  final String frameId;

  @override
  FutureOr<void> runNotifierBuild(
    covariant FrameController notifier,
  ) {
    return notifier.build(
      frameId: frameId,
    );
  }

  @override
  Override overrideWith(FrameController Function() create) {
    return ProviderOverride(
      origin: this,
      override: FrameControllerProvider._internal(
        () => create()..frameId = frameId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        frameId: frameId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FrameController, void>
      createElement() {
    return _FrameControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FrameControllerProvider && other.frameId == frameId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, frameId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FrameControllerRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `frameId` of this provider.
  String get frameId;
}

class _FrameControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FrameController, void>
    with FrameControllerRef {
  _FrameControllerProviderElement(super.provider);

  @override
  String get frameId => (origin as FrameControllerProvider).frameId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
