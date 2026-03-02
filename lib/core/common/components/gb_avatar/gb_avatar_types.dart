/// Avatar sizes
enum GbAvatarSize { xxs, xs, sm, md, lg, xl, xxl }

/// What content the avatar displays
enum GbAvatarContent { image, initials, placeholder }

/// Visual state (for future extensibility)
enum GbAvatarState { defaultState, pressed }

/// Semantic color variants
enum GbAvatarColor { gray, blue, cyan, pink, purple, green, yellow }

/// Presence indicator (dot)
enum GbAvatarStatus { none, online, offline }

/// Symbolic overlay badge (icon-based)
enum GbAvatarBadge { none, verified, company }

/// Overlay layout type (GEOMETRY ONLY)
enum GbAvatarOverlayType { status, company, verified }
