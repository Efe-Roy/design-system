import 'package:flutter/material.dart';

//======Primitive======
const double fontSizeD2xl = 48.0;
const double fontLineHeightD2xl = 1.375;
const double fontLetterSpacingD2xl = -0.96;

const double fontSizeDxl = 40.0;
const double fontLineHeightDxl = 1.25;
const double fontLetterSpacingDxl = -0.8;

const double fontSizeDLg = 32.0;
const double fontLineHeightDLg = 1.25;
const double fontLetterSpacingDLg = -0.72;

const double fontSizeDMd = 28;
const double fontLineHeightDMd = 1.22;
const double fontLetterSpacingDMd = 0.00;

const double fontSizeDSm = 24;
const double fontLineHeightDSm = 1.33;
const double fontLetterSpacingDSm = 0.00;

const double fontSizeDXs = 20;
const double fontLineHeightDXs = 1.40;
const double fontLetterSpacingDXs = 0.00;

const double fontSizeTXl = 20;
const double fontLineHeightTXl = 1.6;
const double fontLetterSpacingTXl = 0.00;

const double fontSizeTLg = 18;
const double fontLineHeightTLg = 1.67;
const double fontLetterSpacingTLg = 0.00;

const double fontSizeTMd = 16;
const double fontLineHeightTMd = 1.69;
const double fontLetterSpacingTMd = 0.00;

const double fontSizeTSm = 14;
const double fontLineHeightTSm = 1.71;
const double fontLetterSpacingTSm = 0.00;

const double fontSizeTXs = 12;
const double fontLineHeightTXs = 1.67;
const double fontLetterSpacingTXs = 0.00;

const double fontSizeTXxs = 10;
const double fontLineHeightTXxs = 1.8;
const double fontLetterSpacingTXxs = 0.00;

class GlobusTypography {
  // ========= Display =========

  // =========================
  // DISPLAY 2XL
  // =========================
  static const TextStyle display2xlBold = TextStyle(
    fontSize: fontSizeD2xl,
    fontWeight: FontWeight.w700, // Bold
    height: fontLineHeightD2xl, // 54px line-height / 48px font-size
    letterSpacing: fontLetterSpacingD2xl,
  );

  static const TextStyle display2xlSemiBold = TextStyle(
    fontSize: fontSizeD2xl,
    fontWeight: FontWeight.w600, // SemiBold
    height: fontLineHeightD2xl,
    letterSpacing: fontLetterSpacingD2xl,
  );

  // =========================
  // DISPLAY XL
  // =========================

  static const TextStyle displayXlBold = TextStyle(
    fontSize: fontSizeDxl,
    fontWeight: FontWeight.w700,
    height: fontLineHeightDxl, // 50px / 40px
    letterSpacing: fontLetterSpacingDxl,
  );

  static const TextStyle displayXlSemiBold = TextStyle(
    fontSize: fontSizeDxl,
    fontWeight: FontWeight.w700,
    height: fontLineHeightDxl, // 50px / 40px
    letterSpacing: fontLetterSpacingDxl,
  );

  // =========================
  // DISPLAY LG
  // =========================

  static const TextStyle displayLgBold = TextStyle(
    fontSize: fontSizeDLg,
    fontWeight: FontWeight.w700,
    height: fontLineHeightDLg, // 40px / 32px
    letterSpacing: fontLetterSpacingDLg,
  );

  static const TextStyle displayLgSemiBold = TextStyle(
    fontSize: fontSizeDLg,
    fontWeight: FontWeight.w600,
    height: fontLineHeightDLg, // 40px / 32px
    letterSpacing: fontLetterSpacingDLg,
  );

  // =========================
  // DISPLAY MD
  // =========================

  static const TextStyle displayMdBold = TextStyle(
    fontSize: fontSizeDMd,
    fontWeight: FontWeight.w700,
    height: fontLineHeightDMd, // 34.2px / 28px
    letterSpacing: fontLetterSpacingDMd,
  );

  static const TextStyle displayMdSemiBold = TextStyle(
    fontSize: fontSizeDMd,
    fontWeight: FontWeight.w600,
    height: fontLineHeightDMd, // 34.2px / 28px
    letterSpacing: fontLetterSpacingDMd,
  );

  // =========================
  // DISPLAY SM
  // =========================

  static const TextStyle displaySmBold = TextStyle(
    fontSize: fontSizeDSm,
    fontWeight: FontWeight.w700,
    height: fontLineHeightDSm, // 32px / 24px
    letterSpacing: fontLetterSpacingDSm,
  );

  static const TextStyle displaySmSemiBold = TextStyle(
    fontSize: fontSizeDSm,
    fontWeight: FontWeight.w600,
    height: fontLineHeightDSm, // 32px / 24px
    letterSpacing: fontLetterSpacingDSm,
  );

  // =========================
  // DISPLAY XS
  // =========================

  static const TextStyle displayXsBold = TextStyle(
    fontSize: fontSizeDXs,
    fontWeight: FontWeight.w700,
    height: fontLineHeightDXs, // 28px / 20px
    letterSpacing: fontLetterSpacingDXs,
  );

  static const TextStyle displayXsSemiBold = TextStyle(
    fontSize: fontSizeDXs,
    fontWeight: FontWeight.w600,
    height: fontLineHeightDXs, // 28px / 20px
    letterSpacing: fontLetterSpacingDXs,
  );

  // =========================
  // TEXT XL
  // =========================
  static const TextStyle textXlBold = TextStyle(
    fontSize: fontSizeTXl,
    fontWeight: FontWeight.w700,
    height: fontLineHeightTXl, // 32 / 20
    letterSpacing: fontLetterSpacingTXl,
  );

  static const TextStyle textXlSemiBold = TextStyle(
    fontSize: fontSizeTXl,
    fontWeight: FontWeight.w600,
    height: fontLineHeightTXl, // 32 / 20
    letterSpacing: fontLetterSpacingTXl,
  );

  static const TextStyle textXlMedium = TextStyle(
    fontSize: fontSizeTXl,
    fontWeight: FontWeight.w500,
    height: fontLineHeightTXl, // 32 / 20
    letterSpacing: fontLetterSpacingTXl,
  );

  static const TextStyle textXlRegular = TextStyle(
    fontSize: fontSizeTXl,
    fontWeight: FontWeight.w400,
    height: fontLineHeightTXl, // 32 / 20
    letterSpacing: fontLetterSpacingTXl,
  );

  // =========================
  // TEXT LG
  // =========================
  static const TextStyle textLgBold = TextStyle(
    fontSize: fontSizeTLg,
    fontWeight: FontWeight.w700,
    height: fontLineHeightTLg, // 30 / 18
    letterSpacing: fontLetterSpacingTLg,
  );

  static const TextStyle textLgSemiBold = TextStyle(
    fontSize: fontSizeTLg,
    fontWeight: FontWeight.w600,
    height: fontLineHeightTLg, // 30 / 18
    letterSpacing: fontLetterSpacingTLg,
  );

  static const TextStyle textLgMedium = TextStyle(
    fontSize: fontSizeTLg,
    fontWeight: FontWeight.w500,
    height: fontLineHeightTLg, // 30 / 18
    letterSpacing: fontLetterSpacingTLg,
  );

  static const TextStyle textLgRegular = TextStyle(
    fontSize: fontSizeTLg,
    fontWeight: FontWeight.w400,
    height: fontLineHeightTLg, // 30 / 18
    letterSpacing: fontLetterSpacingTLg,
  );

  // =========================
  // TEXT MD
  // =========================
  static const TextStyle textMdBold = TextStyle(
    fontSize: fontSizeTMd,
    fontWeight: FontWeight.w700,
    height: fontLineHeightTMd, // 27 / 16
    letterSpacing: fontLetterSpacingTMd,
  );

  static const TextStyle textMdSemiBold = TextStyle(
    fontSize: fontSizeTMd,
    fontWeight: FontWeight.w600,
    height: fontLineHeightTMd, // 27 / 16
    letterSpacing: fontLetterSpacingTMd,
  );

  static const TextStyle textMdMedium = TextStyle(
    fontSize: fontSizeTMd,
    fontWeight: FontWeight.w500,
    height: fontLineHeightTMd, // 27 / 16
    letterSpacing: fontLetterSpacingTMd,
  );

  static const TextStyle textMdRegular = TextStyle(
    fontSize: fontSizeTMd,
    fontWeight: FontWeight.w400,
    height: fontLineHeightTMd, // 27 / 16
    letterSpacing: fontLetterSpacingTMd,
  );

  // =========================
  // TEXT SM
  // =========================
  static const TextStyle textSmBold = TextStyle(
    fontSize: fontSizeTSm,
    fontWeight: FontWeight.w700,
    height: fontLineHeightTSm, // 24 / 14
    letterSpacing: fontLetterSpacingTSm,
  );

  static const TextStyle textSmSemiBold = TextStyle(
    fontSize: fontSizeTSm,
    fontWeight: FontWeight.w600,
    height: fontLineHeightTSm, // 24 / 14
    letterSpacing: fontLetterSpacingTSm,
  );

  static const TextStyle textSmMedium = TextStyle(
    fontSize: fontSizeTSm,
    fontWeight: FontWeight.w500,
    height: fontLineHeightTSm, // 24 / 14
    letterSpacing: fontLetterSpacingTSm,
  );

  static const TextStyle textSmRegular = TextStyle(
    fontSize: fontSizeTSm,
    fontWeight: FontWeight.w400,
    height: fontLineHeightTSm, // 24 / 14
    letterSpacing: fontLetterSpacingTSm,
  );

  // =========================
  // TEXT XS
  // =========================
  static const TextStyle textXsBold = TextStyle(
    fontSize: fontSizeTXs,
    fontWeight: FontWeight.w700,
    height: fontLineHeightTXs, // 20 / 12
    letterSpacing: fontLetterSpacingTXs,
  );

  static const TextStyle textXsSemiBold = TextStyle(
    fontSize: fontSizeTXs,
    fontWeight: FontWeight.w600,
    height: fontLineHeightTXs, // 20 / 12
    letterSpacing: fontLetterSpacingTXs,
  );

  static const TextStyle textXsMedium = TextStyle(
    fontSize: fontSizeTXs,
    fontWeight: FontWeight.w500,
    height: fontLineHeightTXs, // 20 / 12
    letterSpacing: fontLetterSpacingTXs,
  );

  static const TextStyle textXsRegular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: fontLineHeightTXs, // 20 / 12
    letterSpacing: fontLetterSpacingTXs,
  );

  // =========================
  // TEXT XXS
  // =========================
  static const TextStyle textXxsBold = TextStyle(
    fontSize: fontSizeTXxs,
    fontWeight: FontWeight.w700,
    height: fontLineHeightTXxs, // 18 / 10
    letterSpacing: fontLetterSpacingTXxs,
  );

  static const TextStyle textXxsSemiBold = TextStyle(
    fontSize: fontSizeTXxs,
    fontWeight: FontWeight.w600,
    height: fontLineHeightTXxs, // 18 / 10
    letterSpacing: fontLetterSpacingTXxs,
  );

  static const TextStyle textXxsMedium = TextStyle(
    fontSize: fontSizeTXxs,
    fontWeight: FontWeight.w500,
    height: fontLineHeightTXxs, // 18 / 10
    letterSpacing: fontLetterSpacingTXxs,
  );

  static const TextStyle textXxsRegular = TextStyle(
    fontSize: fontSizeTXxs,
    fontWeight: FontWeight.w400,
    height: fontLineHeightTXxs, // 18 / 10
    letterSpacing: fontLetterSpacingTXxs,
  );
}
