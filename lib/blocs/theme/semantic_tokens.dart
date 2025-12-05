// core/theme/semantic_tokens.dart
import 'package:flutter/material.dart';
import 'color_tokens.dart';

class SemanticColors {
  final Color colorBgSurface;
  final Color colorBgElevated;
  final Color colorTextPrimary;
  final Color colorTextSecondary;
  final Color colorTextOnAccent;
  final Color colorBorder;
  final Color colorAccent;
  final Color backgroundColor;

  //Texts
  final Color textBold;
  final Color text;
  final Color textSubtle;
  final Color textDisabled;
  final Color textInverse;
  final Color textBrandDarkBlue;
  final Color textBrandRed;
  final Color textSelected;
  final Color textDangerBold;
  final Color textDanger;
  final Color textDangerSubtle;
  final Color textDangerInverse;
  final Color textWarningBold;
  final Color textWarning;
  final Color textWarningSubtle;
  final Color textSuccessBold;
  final Color textSuccess;
  final Color textSuccessSubtle;
  final Color textDiscoveryBold;
  final Color textDiscovery;
  final Color textDiscoverySubtle;
  final Color textInformationBold;
  final Color textInformation;
  final Color textInformationSubtle;
  final Color textPurpleBold;
  final Color textPurple;
  final Color textPurpleSubtle;
  final Color textPinkBold;
  final Color textPink;
  final Color textPinkSubtle;

  //Links
  final Color link;
  final Color linkPressed;
  final Color linkVisited;

  // Icon-related properties
  final Color iconBolder;
  final Color icon;
  final Color iconSubtle;
  final Color iconDisabled;
  final Color iconInverse;
  final Color iconDarkBlue;
  final Color iconBrandRed;
  final Color iconSelected;
  final Color iconDanger;
  final Color iconDangerInverse;
  final Color iconDangerBolder;
  final Color iconWarning;
  final Color iconWarningBolder;
  final Color iconSuccess;
  final Color iconSuccessBolder;
  final Color iconDiscovery;
  final Color iconDiscoveryBolder;
  final Color iconInformation;
  final Color iconInformationBolder;
  final Color iconPurple;
  final Color iconPurpleBolder;
  final Color iconPink;
  final Color iconPinkBolder;

  // Border-related properties
  final Color borderBolder;
  final Color border;
  final Color borderSubtle;
  final Color borderSubtler;
  final Color borderDisabled;
  final Color borderInverse;
  final Color borderInput;
  final Color borderFocus;
  final Color borderSelected;
  final Color borderDarkBlue;
  final Color borderBrandRed;
  final Color borderDangerBolder;
  final Color borderDanger;
  final Color borderDangerSubtle;
  final Color borderDangerSubtler;
  final Color borderWarningBolder;
  final Color borderWarning;
  final Color borderWarningSubtle;
  final Color borderWarningSubtler;
  final Color borderSuccessBolder;
  final Color borderSuccess;
  final Color borderSuccessSubtle;
  final Color borderSuccessSubtler;
  final Color borderDiscoveryBolder;
  final Color borderDiscovery;
  final Color borderDiscoverySubtle;
  final Color borderDiscoverySubtler;
  final Color borderInformationBolder;
  final Color borderInformation;
  final Color borderInformationSubtle;
  final Color borderInformationSubtler;
  final Color borderPurpleBolder;
  final Color borderPurple;
  final Color borderPurpleSubtle;
  final Color borderPurpleSubtler;
  final Color borderPinkBold;
  final Color borderPink;
  final Color borderPinkSubtle;
  final Color borderPinkSubtler;

  // Background-related properties
  final Color backgroundCardBolder;
  final Color backgroundCard;
  final Color backgroundInput;
  final Color backgroundDisabled;
  final Color backgroundBtnDisabled;
  final Color backgroundSelected;
  final Color backgroundDarkBlue;
  final Color backgroundBrandRed;
  final Color backgroundBrandRedHover;
  final Color backgroundBrandRedPressed;
  final Color backgroundGrayBolder;
  final Color backgroundGray;
  final Color backgroundGraySubtle;
  final Color backgroundGraySubtler;
  final Color backgroundGraySubtlest;
  final Color backgroundDangerBolder;
  final Color backgroundDanger;
  final Color backgroundDangerSubtle;
  final Color backgroundDangerSubtler;
  final Color backgroundDangerSubtlest;
  final Color backgroundWarningBold;
  final Color backgroundWarning;
  final Color backgroundWarningSubtle;
  final Color backgroundWarningSubtler;
  final Color backgroundWarningSubtlest;
  final Color backgroundSuccessBolder;
  final Color backgroundSuccess;
  final Color backgroundSuccessSubtle;
  final Color backgroundSuccessSubtler;
  final Color backgroundSuccessSubtlest;
  final Color backgroundDiscoveryBolder;
  final Color backgroundDiscovery;
  final Color backgroundDiscoverySubtle;
  final Color backgroundDiscoverySubtler;
  final Color backgroundDiscoverySubtlest;
  final Color backgroundInformationBolder;
  final Color backgroundInformation;
  final Color backgroundInformationSubtle;
  final Color backgroundInformationSubtler;
  final Color backgroundInformationSubtlest;
  final Color backgroundPurpleBolder;
  final Color backgroundPurple;
  final Color backgroundPurpleSubtle;
  final Color backgroundPurpleSubtler;
  final Color backgroundPurpleSubtlest;
  final Color backgroundPinkBolder;
  final Color backgroundPink;
  final Color backgroundPinkSubtle;
  final Color backgroundPinkSubtler;
  final Color backgroundPinkSubtlest;

  // Blanket-related properties
  final Color blanket;
  final Color blanketSubtle;
  final Color blanketSubtler;

  // Skeleton-related properties
  final Color skeleton;

  // Surface-related properties
  final Color surfaceBold;
  final Color surface;
  final Color surfaceHovered;
  final Color surfacePressed;

  // Transparent-related properties
  final Color surfaceTransparent50;
  final Color surfaceTransparent20;
  final Color surfaceTransparentFull;
  final Color surfaceBoldTransparent50;
  final Color surfaceBoldTransparent20;
  final Color surfaceBoldTransparentFull;

  const SemanticColors({
    required this.colorBgSurface,
    required this.colorBgElevated,
    required this.colorTextPrimary,
    required this.colorTextSecondary,
    required this.colorTextOnAccent,
    required this.colorBorder,
    required this.colorAccent,
    required this.backgroundColor,

    //Texts
    required this.textBold,
    required this.text,
    required this.textSubtle,
    required this.textDisabled,
    required this.textInverse,
    required this.textBrandDarkBlue,
    required this.textBrandRed,
    required this.textSelected,
    required this.textDangerBold,
    required this.textDanger,
    required this.textDangerSubtle,
    required this.textDangerInverse,
    required this.textWarningBold,
    required this.textWarning,
    required this.textWarningSubtle,
    required this.textSuccessBold,
    required this.textSuccess,
    required this.textSuccessSubtle,
    required this.textDiscoveryBold,
    required this.textDiscovery,
    required this.textDiscoverySubtle,
    required this.textInformationBold,
    required this.textInformation,
    required this.textInformationSubtle,
    required this.textPurpleBold,
    required this.textPurple,
    required this.textPurpleSubtle,
    required this.textPinkBold,
    required this.textPink,
    required this.textPinkSubtle,

    //Links
    required this.link,
    required this.linkPressed,
    required this.linkVisited,

    // Icon-related properties
    required this.iconBolder,
    required this.icon,
    required this.iconSubtle,
    required this.iconDisabled,
    required this.iconInverse,
    required this.iconDarkBlue,
    required this.iconBrandRed,
    required this.iconSelected,
    required this.iconDanger,
    required this.iconDangerInverse,
    required this.iconDangerBolder,
    required this.iconWarning,
    required this.iconWarningBolder,
    required this.iconSuccess,
    required this.iconSuccessBolder,
    required this.iconDiscovery,
    required this.iconDiscoveryBolder,
    required this.iconInformation,
    required this.iconInformationBolder,
    required this.iconPurple,
    required this.iconPurpleBolder,
    required this.iconPink,
    required this.iconPinkBolder,

    // Border-related properties
    required this.borderBolder,
    required this.border,
    required this.borderSubtle,
    required this.borderSubtler,
    required this.borderDisabled,
    required this.borderInverse,
    required this.borderInput,
    required this.borderFocus,
    required this.borderSelected,
    required this.borderDarkBlue,
    required this.borderBrandRed,
    required this.borderDangerBolder,
    required this.borderDanger,
    required this.borderDangerSubtle,
    required this.borderDangerSubtler,
    required this.borderWarningBolder,
    required this.borderWarning,
    required this.borderWarningSubtle,
    required this.borderWarningSubtler,
    required this.borderSuccessBolder,
    required this.borderSuccess,
    required this.borderSuccessSubtle,
    required this.borderSuccessSubtler,
    required this.borderDiscoveryBolder,
    required this.borderDiscovery,
    required this.borderDiscoverySubtle,
    required this.borderDiscoverySubtler,
    required this.borderInformationBolder,
    required this.borderInformation,
    required this.borderInformationSubtle,
    required this.borderInformationSubtler,
    required this.borderPurpleBolder,
    required this.borderPurple,
    required this.borderPurpleSubtle,
    required this.borderPurpleSubtler,
    required this.borderPinkBold,
    required this.borderPink,
    required this.borderPinkSubtle,
    required this.borderPinkSubtler,

    // Background-related properties
    required this.backgroundCardBolder,
    required this.backgroundCard,
    required this.backgroundInput,
    required this.backgroundDisabled,
    required this.backgroundBtnDisabled,
    required this.backgroundSelected,
    required this.backgroundDarkBlue,
    required this.backgroundBrandRed,
    required this.backgroundBrandRedHover,
    required this.backgroundBrandRedPressed,
    required this.backgroundGrayBolder,
    required this.backgroundGray,
    required this.backgroundGraySubtle,
    required this.backgroundGraySubtler,
    required this.backgroundGraySubtlest,
    required this.backgroundDangerBolder,
    required this.backgroundDanger,
    required this.backgroundDangerSubtle,
    required this.backgroundDangerSubtler,
    required this.backgroundDangerSubtlest,
    required this.backgroundWarningBold,
    required this.backgroundWarning,
    required this.backgroundWarningSubtle,
    required this.backgroundWarningSubtler,
    required this.backgroundWarningSubtlest,
    required this.backgroundSuccessBolder,
    required this.backgroundSuccess,
    required this.backgroundSuccessSubtle,
    required this.backgroundSuccessSubtler,
    required this.backgroundSuccessSubtlest,
    required this.backgroundDiscoveryBolder,
    required this.backgroundDiscovery,
    required this.backgroundDiscoverySubtle,
    required this.backgroundDiscoverySubtler,
    required this.backgroundDiscoverySubtlest,
    required this.backgroundInformationBolder,
    required this.backgroundInformation,
    required this.backgroundInformationSubtle,
    required this.backgroundInformationSubtler,
    required this.backgroundInformationSubtlest,
    required this.backgroundPurpleBolder,
    required this.backgroundPurple,
    required this.backgroundPurpleSubtle,
    required this.backgroundPurpleSubtler,
    required this.backgroundPurpleSubtlest,
    required this.backgroundPinkBolder,
    required this.backgroundPink,
    required this.backgroundPinkSubtle,
    required this.backgroundPinkSubtler,
    required this.backgroundPinkSubtlest,

    // Blanket-related properties
    required this.blanket,
    required this.blanketSubtle,
    required this.blanketSubtler,

    // Skeleton-related properties
    required this.skeleton,

    // Surface-related properties
    required this.surfaceBold,
    required this.surface,
    required this.surfaceHovered,
    required this.surfacePressed,

    // Transparent-related properties
    required this.surfaceTransparent50,
    required this.surfaceTransparent20,
    required this.surfaceTransparentFull,
    required this.surfaceBoldTransparent50,
    required this.surfaceBoldTransparent20,
    required this.surfaceBoldTransparentFull,
  });

  factory SemanticColors.light() {
    return const SemanticColors(
      colorBgSurface: Colors.white,
      colorBgElevated: ColorTokens.gray50,
      colorTextPrimary: ColorTokens.gray900,
      colorTextSecondary: ColorTokens.gray600,
      colorTextOnAccent: Colors.white,
      colorBorder: ColorTokens.gray200,
      colorAccent: ColorTokens.primary,
      backgroundColor: ColorTokens.white,

      //Texts
      textBold: ColorTokens.gray800,
      text: ColorTokens.gray600,
      textSubtle: ColorTokens.gray500,
      textDisabled: ColorTokens.gray400,
      textInverse: ColorTokens.white,
      textBrandDarkBlue: ColorTokens.darkBlue500,
      textBrandRed: ColorTokens.red500,
      textSelected: ColorTokens.blue500,
      textDangerBold: ColorTokens.red800,
      textDanger: ColorTokens.red700,
      textDangerSubtle: ColorTokens.red600,
      textDangerInverse: ColorTokens.white,
      textWarningBold: ColorTokens.warning800,
      textWarning: ColorTokens.warning600,
      textWarningSubtle: ColorTokens.warning500,
      textSuccessBold: ColorTokens.success800,
      textSuccess: ColorTokens.success600,
      textSuccessSubtle: ColorTokens.success400,
      textDiscoveryBold: ColorTokens.lightBlue800,
      textDiscovery: ColorTokens.lightBlue600,
      textDiscoverySubtle: ColorTokens.lightBlue500,
      textInformationBold: ColorTokens.blue800,
      textInformation: ColorTokens.blue600,
      textInformationSubtle: ColorTokens.blue500,
      textPurpleBold: ColorTokens.purple800,
      textPurple: ColorTokens.purple600,
      textPurpleSubtle: ColorTokens.purple500,
      textPinkBold: ColorTokens.pink800,
      textPink: ColorTokens.pink600,
      textPinkSubtle: ColorTokens.pink500,

      //Links
      link: ColorTokens.blue500,
      linkPressed: ColorTokens.blue600,
      linkVisited: ColorTokens.lightBlue600,

      // Icon-related properties
      iconBolder: ColorTokens.gray800,
      icon: ColorTokens.gray600,
      iconSubtle: ColorTokens.gray500,
      iconDisabled: ColorTokens.gray400,
      iconInverse: ColorTokens.white,
      iconDarkBlue: ColorTokens.darkBlue500,
      iconBrandRed: ColorTokens.red500,
      iconSelected: ColorTokens.blue500,
      iconDanger: ColorTokens.red700,
      iconDangerInverse: ColorTokens.red500,
      iconDangerBolder: ColorTokens.red800,
      iconWarning: ColorTokens.warning600,
      iconWarningBolder: ColorTokens.warning800,
      iconSuccess: ColorTokens.success600,
      iconSuccessBolder: ColorTokens.success800,
      iconDiscovery: ColorTokens.lightBlue600,
      iconDiscoveryBolder: ColorTokens.lightBlue800,
      iconInformation: ColorTokens.blue600,
      iconInformationBolder: ColorTokens.blue800,
      iconPurple: ColorTokens.purple600,
      iconPurpleBolder: ColorTokens.purple800,
      iconPink: ColorTokens.pink600,
      iconPinkBolder: ColorTokens.pink800,

      // Border-related properties
      borderBolder: ColorTokens.gray500,
      border: ColorTokens.gray400,
      borderSubtle: ColorTokens.gray300,
      borderSubtler: ColorTokens.gray200,
      borderDisabled: ColorTokens.gray200,
      borderInverse: ColorTokens.white,
      borderInput: ColorTokens.gray300,
      borderFocus: ColorTokens.blue500,
      borderSelected: ColorTokens.blue500,
      borderDarkBlue: ColorTokens.darkBlue500,
      borderBrandRed: ColorTokens.red500,
      borderDangerBolder: ColorTokens.red800,
      borderDanger: ColorTokens.red700,
      borderDangerSubtle: ColorTokens.red600,
      borderDangerSubtler: ColorTokens.red100,
      borderWarningBolder: ColorTokens.warning800,
      borderWarning: ColorTokens.warning600,
      borderWarningSubtle: ColorTokens.warning200,
      borderWarningSubtler: ColorTokens.warning100,
      borderSuccessBolder: ColorTokens.success800,
      borderSuccess: ColorTokens.success600,
      borderSuccessSubtle: ColorTokens.success300,
      borderSuccessSubtler: ColorTokens.success100,
      borderDiscoveryBolder: ColorTokens.lightBlue800,
      borderDiscovery: ColorTokens.lightBlue600,
      borderDiscoverySubtle: ColorTokens.lightBlue300,
      borderDiscoverySubtler: ColorTokens.lightBlue100,
      borderInformationBolder: ColorTokens.blue800,
      borderInformation: ColorTokens.blue600,
      borderInformationSubtle: ColorTokens.blue300,
      borderInformationSubtler: ColorTokens.blue100,
      borderPurpleBolder: ColorTokens.purple800,
      borderPurple: ColorTokens.purple600,
      borderPurpleSubtle: ColorTokens.purple300,
      borderPurpleSubtler: ColorTokens.purple100,
      borderPinkBold: ColorTokens.pink800,
      borderPink: ColorTokens.pink600,
      borderPinkSubtle: ColorTokens.pink300,
      borderPinkSubtler: ColorTokens.pink100,

      // Background-related properties
      backgroundCardBolder: ColorTokens.gray100,
      backgroundCard: ColorTokens.white,
      backgroundInput: ColorTokens.white,
      backgroundDisabled: ColorTokens.gray50,
      backgroundBtnDisabled: ColorTokens.gray200,
      backgroundSelected: ColorTokens.blue500,
      backgroundDarkBlue: ColorTokens.darkBlue500,
      backgroundBrandRed: ColorTokens.red500,
      backgroundBrandRedHover: ColorTokens.red600,
      backgroundBrandRedPressed: ColorTokens.red700,
      backgroundGrayBolder: ColorTokens.gray400,
      backgroundGray: ColorTokens.gray300,
      backgroundGraySubtle: ColorTokens.gray200,
      backgroundGraySubtler: ColorTokens.gray100,
      backgroundGraySubtlest: ColorTokens.gray50,
      backgroundDangerBolder: ColorTokens.red800,
      backgroundDanger: ColorTokens.red700,
      backgroundDangerSubtle: ColorTokens.red600,
      backgroundDangerSubtler: ColorTokens.red100,
      backgroundDangerSubtlest: ColorTokens.red50,
      backgroundWarningBold: ColorTokens.warning800,
      backgroundWarning: ColorTokens.warning600,
      backgroundWarningSubtle: ColorTokens.warning200,
      backgroundWarningSubtler: ColorTokens.warning100,
      backgroundWarningSubtlest: ColorTokens.warning50,
      backgroundSuccessBolder: ColorTokens.success800,
      backgroundSuccess: ColorTokens.success600,
      backgroundSuccessSubtle: ColorTokens.success300,
      backgroundSuccessSubtler: ColorTokens.success100,
      backgroundSuccessSubtlest: ColorTokens.success50,
      backgroundDiscoveryBolder: ColorTokens.lightBlue800,
      backgroundDiscovery: ColorTokens.lightBlue600,
      backgroundDiscoverySubtle: ColorTokens.lightBlue300,
      backgroundDiscoverySubtler: ColorTokens.lightBlue100,
      backgroundDiscoverySubtlest: ColorTokens.lightBlue50,
      backgroundInformationBolder: ColorTokens.blue800,
      backgroundInformation: ColorTokens.blue600,
      backgroundInformationSubtle: ColorTokens.blue300,
      backgroundInformationSubtler: ColorTokens.blue100,
      backgroundInformationSubtlest: ColorTokens.blue50,
      backgroundPurpleBolder: ColorTokens.purple800,
      backgroundPurple: ColorTokens.purple600,
      backgroundPurpleSubtle: ColorTokens.purple300,
      backgroundPurpleSubtler: ColorTokens.purple100,
      backgroundPurpleSubtlest: ColorTokens.purple50,
      backgroundPinkBolder: ColorTokens.pink800,
      backgroundPink: ColorTokens.pink600,
      backgroundPinkSubtle: ColorTokens.pink300,
      backgroundPinkSubtler: ColorTokens.pink100,
      backgroundPinkSubtlest: ColorTokens.pink50,

      // Blanket-related properties
      blanket: ColorTokens.darkBlue200Opa40,
      blanketSubtle: ColorTokens.darkBlue200Opa30,
      blanketSubtler: ColorTokens.darkBlue200Opa20,

      // Skeleton-related properties
      skeleton: ColorTokens.gray200,

      // Surface-related properties
      surfaceBold: ColorTokens.gray25,
      surface: ColorTokens.white,
      surfaceHovered: ColorTokens.gray100,
      surfacePressed: ColorTokens.gray200,

      // Transparent-related properties
      surfaceTransparent50: ColorTokens.gray900Opa50,
      surfaceTransparent20: ColorTokens.gray900Opa20,
      surfaceTransparentFull: ColorTokens.gray900Opa0,
      surfaceBoldTransparent50: ColorTokens.gray950Opa50,
      surfaceBoldTransparent20: ColorTokens.gray950Opa20,
      surfaceBoldTransparentFull: ColorTokens.gray950Opa0,
    );
  }

  factory SemanticColors.dark() {
    return const SemanticColors(
      colorBgSurface: ColorTokens.gray900,
      colorBgElevated: ColorTokens.gray800,
      colorTextPrimary: Colors.white,
      colorTextSecondary: ColorTokens.gray300,
      colorTextOnAccent: Colors.black,
      colorBorder: ColorTokens.gray700,
      colorAccent: ColorTokens.primary,
      backgroundColor: ColorTokens.black,

      //Texts
      textBold: ColorTokens.gray100,
      text: ColorTokens.gray300,
      textSubtle: ColorTokens.gray400,
      textDisabled: ColorTokens.gray500,
      textInverse: ColorTokens.gray800,
      textBrandDarkBlue: ColorTokens.darkBlue100,
      textBrandRed: ColorTokens.red300,
      textSelected: ColorTokens.blue300,
      textDangerBold: ColorTokens.red100,
      textDanger: ColorTokens.red200,
      textDangerSubtle: ColorTokens.red300,
      textDangerInverse: ColorTokens.red950,
      textWarningBold: ColorTokens.warning100,
      textWarning: ColorTokens.warning300,
      textWarningSubtle: ColorTokens.warning400,
      textSuccessBold: ColorTokens.success100,
      textSuccess: ColorTokens.success300,
      textSuccessSubtle: ColorTokens.success500,
      textDiscoveryBold: ColorTokens.lightBlue100,
      textDiscovery: ColorTokens.lightBlue300,
      textDiscoverySubtle: ColorTokens.lightBlue400,
      textInformationBold: ColorTokens.blue100,
      textInformation: ColorTokens.blue300,
      textInformationSubtle: ColorTokens.blue400,
      textPurpleBold: ColorTokens.blue100,
      textPurple: ColorTokens.purple300,
      textPurpleSubtle: ColorTokens.purple400,
      textPinkBold: ColorTokens.pink100,
      textPink: ColorTokens.pink300,
      textPinkSubtle: ColorTokens.pink400,

      //Links
      link: ColorTokens.blue300,
      linkPressed: ColorTokens.blue200,
      linkVisited: ColorTokens.lightBlue300,

      // Icon-related properties
      iconBolder: ColorTokens.gray100,
      icon: ColorTokens.gray300,
      iconSubtle: ColorTokens.gray400,
      iconDisabled: ColorTokens.gray500,
      iconInverse: ColorTokens.gray800,
      iconDarkBlue: ColorTokens.darkBlue100,
      iconBrandRed: ColorTokens.red300,
      iconSelected: ColorTokens.blue300,
      iconDanger: ColorTokens.red200,
      iconDangerInverse: ColorTokens.red950,
      iconDangerBolder: ColorTokens.red100,
      iconWarning: ColorTokens.warning300,
      iconWarningBolder: ColorTokens.warning100,
      iconSuccess: ColorTokens.success300,
      iconSuccessBolder: ColorTokens.success100,
      iconDiscovery: ColorTokens.lightBlue300,
      iconDiscoveryBolder: ColorTokens.lightBlue100,
      iconInformation: ColorTokens.blue300,
      iconInformationBolder: ColorTokens.blue100,
      iconPurple: ColorTokens.purple300,
      iconPurpleBolder: ColorTokens.purple100,
      iconPink: ColorTokens.pink300,
      iconPinkBolder: ColorTokens.pink100,

      // Border-related properties
      borderBolder: ColorTokens.gray400,
      border: ColorTokens.gray500,
      borderSubtle: ColorTokens.gray700,
      borderSubtler: ColorTokens.gray800,
      borderDisabled: ColorTokens.gray700,
      borderInverse: ColorTokens.gray800,
      borderInput: ColorTokens.gray600,
      borderFocus: ColorTokens.blue200,
      borderSelected: ColorTokens.blue300,
      borderDarkBlue: ColorTokens.darkBlue200,
      borderBrandRed: ColorTokens.red300,
      borderDangerBolder: ColorTokens.red100,
      borderDanger: ColorTokens.red200,
      borderDangerSubtle: ColorTokens.red300,
      borderDangerSubtler: ColorTokens.red950,
      borderWarningBolder: ColorTokens.warning100,
      borderWarning: ColorTokens.warning300,
      borderWarningSubtle: ColorTokens.warning800,
      borderWarningSubtler: ColorTokens.warning900,
      borderSuccessBolder: ColorTokens.success100,
      borderSuccess: ColorTokens.success300,
      borderSuccessSubtle: ColorTokens.success200,
      borderSuccessSubtler: ColorTokens.success900,
      borderDiscoveryBolder: ColorTokens.lightBlue100,
      borderDiscovery: ColorTokens.lightBlue300,
      borderDiscoverySubtle: ColorTokens.lightBlue200,
      borderDiscoverySubtler: ColorTokens.lightBlue900,
      borderInformationBolder: ColorTokens.blue100,
      borderInformation: ColorTokens.blue300,
      borderInformationSubtle: ColorTokens.blue200,
      borderInformationSubtler: ColorTokens.blue900,
      borderPurpleBolder: ColorTokens.purple100,
      borderPurple: ColorTokens.purple300,
      borderPurpleSubtle: ColorTokens.purple500,
      borderPurpleSubtler: ColorTokens.purple900,
      borderPinkBold: ColorTokens.pink100,
      borderPink: ColorTokens.pink300,
      borderPinkSubtle: ColorTokens.pink200,
      borderPinkSubtler: ColorTokens.pink900,

      // Background-related properties
      backgroundCardBolder: ColorTokens.gray800,
      backgroundCard: ColorTokens.gray900,
      backgroundInput: ColorTokens.gray950,
      backgroundDisabled: ColorTokens.gray800,
      backgroundBtnDisabled: ColorTokens.gray700,
      backgroundSelected: ColorTokens.blue300,
      backgroundDarkBlue: ColorTokens.darkBlue200,
      backgroundBrandRed: ColorTokens.red300,
      backgroundBrandRedHover: ColorTokens.red200,
      backgroundBrandRedPressed: ColorTokens.red100,
      backgroundGrayBolder: ColorTokens.gray500,
      backgroundGray: ColorTokens.gray600,
      backgroundGraySubtle: ColorTokens.gray700,
      backgroundGraySubtler: ColorTokens.gray800,
      backgroundGraySubtlest: ColorTokens.gray950,
      backgroundDangerBolder: ColorTokens.red100,
      backgroundDanger: ColorTokens.red200,
      backgroundDangerSubtle: ColorTokens.red300,
      backgroundDangerSubtler: ColorTokens.red950,
      backgroundDangerSubtlest: ColorTokens.red900,
      backgroundWarningBold: ColorTokens.warning100,
      backgroundWarning: ColorTokens.warning300,
      backgroundWarningSubtle: ColorTokens.warning800,
      backgroundWarningSubtler: ColorTokens.warning900,
      backgroundWarningSubtlest: ColorTokens.warning950,
      backgroundSuccessBolder: ColorTokens.success100,
      backgroundSuccess: ColorTokens.success300,
      backgroundSuccessSubtle: ColorTokens.success200,
      backgroundSuccessSubtler: ColorTokens.success900,
      backgroundSuccessSubtlest: ColorTokens.success950,
      backgroundDiscoveryBolder: ColorTokens.lightBlue100,
      backgroundDiscovery: ColorTokens.lightBlue300,
      backgroundDiscoverySubtle: ColorTokens.lightBlue200,
      backgroundDiscoverySubtler: ColorTokens.lightBlue900,
      backgroundDiscoverySubtlest: ColorTokens.lightBlue950,
      backgroundInformationBolder: ColorTokens.blue100,
      backgroundInformation: ColorTokens.blue300,
      backgroundInformationSubtle: ColorTokens.blue200,
      backgroundInformationSubtler: ColorTokens.blue900,
      backgroundInformationSubtlest: ColorTokens.blue950,
      backgroundPurpleBolder: ColorTokens.purple100,
      backgroundPurple: ColorTokens.purple300,
      backgroundPurpleSubtle: ColorTokens.purple500,
      backgroundPurpleSubtler: ColorTokens.purple900,
      backgroundPurpleSubtlest: ColorTokens.purple950,
      backgroundPinkBolder: ColorTokens.pink100,
      backgroundPink: ColorTokens.pink300,
      backgroundPinkSubtle: ColorTokens.pink200,
      backgroundPinkSubtler: ColorTokens.pink900,
      backgroundPinkSubtlest: ColorTokens.pink950,

      // Blanket-related properties
      blanket: ColorTokens.darkBlue500Opa40,
      blanketSubtle: ColorTokens.darkBlue500Opa30,
      blanketSubtler: ColorTokens.darkBlue500Opa20,

      // Skeleton-related properties
      skeleton: ColorTokens.gray800,

      // Surface-related properties
      surfaceBold: ColorTokens.gray950,
      surface: ColorTokens.gray900,
      surfaceHovered: ColorTokens.gray800,
      surfacePressed: ColorTokens.gray700,

      // Transparent-related properties
      surfaceTransparent50: ColorTokens.whiteOpa50,
      surfaceTransparent20: ColorTokens.whiteOpa20,
      surfaceTransparentFull: ColorTokens.whiteOpa0,
      surfaceBoldTransparent50: ColorTokens.gray25Opa50,
      surfaceBoldTransparent20: ColorTokens.gray25Opa20,
      surfaceBoldTransparentFull: ColorTokens.gray25Opa0,
    );
  }
}
