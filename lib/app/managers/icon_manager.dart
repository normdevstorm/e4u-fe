part of '../app.dart';

/// Icon Manager - Centralized icon asset paths
///
/// Note: After running `fluttergen` or `flutter pub run build_runner build`,
/// you can use the generated `Assets.icons.*` classes from flutter_gen
/// for type-safe icon access.
///
/// This class provides a convenient wrapper around flutter_gen's generated assets.
/// Once icons are added to assets/icons/, flutter_gen will generate type-safe accessors.
class IconManager {
  // Base paths for reference
  static const String _iconsPath = 'assets/icons';
  static const String _svgPath = '$_iconsPath/svg';

  // Navigation Icons
  static const String leftArrow = '$_svgPath/left_arrow.svg';
  static const String rightArrow = '$_svgPath/right_arrow.svg';
  static const String arrowLeftRound = '$_svgPath/arrow_left_01_round.svg';
  static const String arrowRightRound = '$_svgPath/arrow_right_01_round.svg';
  static const String arrowUpRound = '$_svgPath/arrow_up_01_round.svg';
  static const String arrowDownRound = '$_svgPath/arrow_down_01_round.svg';
  static const String arrowUpRightRound =
      '$_svgPath/arrow_up_right_01_round.svg';

  // Common UI Icons
  static const String more = '$_svgPath/more.svg';
  static const String cross = '$_svgPath/cross.svg';
  static const String checkmark = '$_svgPath/checkmark.svg';
  static const String checkmarkCircle = '$_svgPath/checkmark_circle_02.svg';
  static const String checkmarkBadge = '$_svgPath/checkmark_badge_02.svg';
  static const String plusSign = '$_svgPath/plus_sign.svg';
  static const String plusSignCircle = '$_svgPath/plus_sign_circle.svg';
  static const String minusSign = '$_svgPath/minus_sign.svg';
  static const String search = '$_svgPath/search.svg';
  static const String filter = '$_svgPath/filter_horizontal.svg';
  static const String sorting = '$_svgPath/sorting_01.svg';
  static const String heart = '$_svgPath/heart.svg';
  static const String star = '$_svgPath/star.svg';
  static const String starCircle = '$_svgPath/star_circle.svg';
  static const String share = '$_svgPath/share.svg';
  static const String delete = '$_svgPath/delete_03.svg';
  static const String repeat = '$_svgPath/repeat.svg';
  static const String download = '$_svgPath/download_01.svg';
  static const String downloadCircle = '$_svgPath/download_circle_02.svg';
  static const String lock = '$_svgPath/lock_keyhole_minimalistic.svg';
  static const String setting = '$_svgPath/setting_02.svg';
  static const String crown = '$_svgPath/crown.svg';
  static const String user = '$_svgPath/user.svg';
  static const String userGroup = '$_svgPath/user_group.svg';
  static const String message = '$_svgPath/message_02.svg';
  static const String calendar = '$_svgPath/calendar_03.svg';
  static const String clock = '$_svgPath/clock.svg';
  static const String target = '$_svgPath/target.svg';
  static const String statistics = '$_svgPath/statistics.svg';
  static const String gem = '$_svgPath/gem.svg';
  static const String words = '$_svgPath/words.svg';
  static const String bulb = '$_svgPath/bulb.svg';
  static const String square = '$_svgPath/square.svg';
  static const String tick = '$_svgPath/tick_02.svg';
  static const String happy = '$_svgPath/happy.svg';
  static const String sign = '$_svgPath/sign.svg';
  static const String other = '$_svgPath/other.svg';

  // Media Icons
  static const String play = '$_svgPath/play.svg';
  static const String pause = '$_svgPath/pause.svg';
  static const String speaker = '$_svgPath/speaker.svg';
  static const String mic = '$_svgPath/mic_02.svg';
  static const String video = '$_svgPath/video_02.svg';
  static const String videoOff = '$_svgPath/video_off.svg';
  static const String camera = '$_svgPath/camera.svg';
  static const String cameraAdd = '$_svgPath/camera_add_01.svg';
  static const String cameraPlus = '$_svgPath/camera_plus.svg';
  static const String image = '$_svgPath/image_02.svg';
  static const String rewind10Forward =
      '$_svgPath/rewind_10_seconds_forward.svg';
  static const String rewind10Back = '$_svgPath/rewind_10_seconds_back.svg';

  // Content Icons
  static const String book = '$_svgPath/book.svg';
  static const String bookOpen = '$_svgPath/book_open_01.svg';
  static const String bookBookmark = '$_svgPath/book_bookmark_02.svg';
  static const String note = '$_svgPath/note.svg';
  static const String pen = '$_svgPath/pen.svg';
  static const String penConnectBluetooth =
      '$_svgPath/pen_connect_bluetooth.svg';
  static const String sent = '$_svgPath/sent.svg';
  static const String pdf = '$_svgPath/pdf_file.svg';
  static const String png = '$_svgPath/png.svg';
  static const String ccSquare = '$_svgPath/cc_square.svg';

  // Feature Icons
  static const String home = '$_svgPath/home_04.svg';
  static const String analytics = '$_svgPath/analytics_01.svg';
  static const String ai = '$_svgPath/ai.svg';
  static const String game = '$_svgPath/game.svg';
  static const String teaching = '$_svgPath/teaching.svg';
  static const String voice = '$_svgPath/voice.svg';
  static const String mortarboard = '$_svgPath/mortarboard_02.svg';
  static const String workBag = '$_svgPath/work_bag.svg';
  static const String camera01 = '$_svgPath/camera_01.svg';
  static const String muscle = '$_svgPath/muscle.svg';
  static const String job = '$_svgPath/job.svg';
  static const String work = '$_svgPath/work.svg';
  static const String burger = '$_svgPath/burger.svg';

  // Interaction Icons
  static const String thumbsUp = '$_svgPath/thumbs_up.svg';
  static const String thumbsDown = '$_svgPath/thumbs_down.svg';
  static const String rejoin = '$_svgPath/rejoin.svg';
  static const String zoomOut = '$_svgPath/zoom_out.svg';
  static const String creditCard = '$_svgPath/credit_card.svg';
  static const String creditCardAdd = '$_svgPath/credit_card_add.svg';

  // Payment Icons
  static const String mastercard = '$_svgPath/mastercard.svg';
  static const String applePay = '$_svgPath/apple_pay.svg';

  // Flag Icons
  static const String flag = '$_svgPath/flag_02.svg';
  static const String flagUsa = '$_svgPath/usa.svg';
  static const String flagUk = '$_svgPath/uk.svg';
  static const String flagAustralia = '$_svgPath/australia.svg';
  static const String flagJapan = '$_svgPath/japan.svg';
  static const String flagChina = '$_svgPath/china.svg';
  static const String flagBangladesh = '$_svgPath/bangladesh.svg';
  static const String flagCanada = '$_svgPath/canada.svg';
  static const String flagSouthAfrica = '$_svgPath/south_africa.svg';

  // Theme Icons
  static const String sun = '$_svgPath/sun.svg';
  static const String night = '$_svgPath/night.svg';

  // Helper method to get icon path by name
  static String? getIconPath(String iconName) {
    // Convert icon name to constant name and return path
    // This allows dynamic icon lookup if needed
    switch (iconName.toLowerCase().replaceAll(' ', '_')) {
      case 'left_arrow':
        return leftArrow;
      case 'right_arrow':
        return rightArrow;
      case 'home':
        return home;
      case 'search':
        return search;
      case 'user':
        return user;
      case 'setting':
        return setting;
      case 'heart':
        return heart;
      case 'star':
        return star;
      case 'camera':
        return camera;
      case 'play':
        return play;
      case 'pause':
        return pause;
      default:
        return null;
    }
  }
}
