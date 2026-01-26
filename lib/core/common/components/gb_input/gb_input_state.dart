import 'gb_input_types.dart';

/// INTERNAL ONLY — used only by tokens.
/// Widgets must NOT expose this type in their public API.
enum GbInputVisualIntent { defaultState, active, disabled }

class GbInputStateResolver {
  const GbInputStateResolver._();

  /// Resolve PUBLIC design state from widget signals (default behavior).
  static GbInputState resolveDesignState({
    required bool enabled,
    required bool focused, // keep if your GbInputField still passes it
    required bool hasValue,
  }) {
    if (!enabled) return GbInputState.disabled;
    if (focused) return GbInputState.active; // active covers focus visuals now
    if (hasValue) return GbInputState.filled;
    return GbInputState.normal;
  }

  /// Map PUBLIC design state -> INTERNAL token intent.
  static GbInputVisualIntent toVisualIntent({
    required GbInputState state,
    required bool destructive,
  }) {
    // Disabled always wins
    if (state == GbInputState.disabled) {
      return GbInputVisualIntent.disabled;
    }

    // For this new model, "active" is the only special state visually
    if (state == GbInputState.active) {
      return GbInputVisualIntent.active;
    }

    // normal / filled
    return GbInputVisualIntent.defaultState;
  }
}
