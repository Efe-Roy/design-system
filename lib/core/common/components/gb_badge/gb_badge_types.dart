enum GbBadgeSize { sm, md, lg }

enum GbBadgeType { pillColor, pillOutline, badgeColor, badgeModern }

/// Matches Figma Property: "Icon"
enum GbBadgeIcon {
  none, // Figma: "false"
  dot, // Figma: "dot"
  country, // Figma: "country"
  xClose, // Figma: "x close"
  avatar, // Figma: "avatar"
  iconTrailing, // Figma: "icon trailing"
  iconLeading, // Figma: "icon leading" (implied from variants)
  only, // Figma: "only"
}

enum GbBadgeColor {
  gray,
  primary,
  error,
  warning,
  success,
  pink,
  discovery,
  information,
  purple,
}
