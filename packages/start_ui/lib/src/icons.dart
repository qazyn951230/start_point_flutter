// MIT License
//
// Copyright (c) 2017-present qazyn951230 qazyn951230@gmail.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

//import 'package:flutter/widgets.dart';
//
//class Icons {
//  Icons._();
//
//  static const String iconFont = 'Icons';
//
//  static const String iconFontPackage = '_icons';
//
//  // Manually maintained list.
//
//  static const IconData left_chevron = IconData(0xf3d2,
//      fontFamily: iconFont,
//      fontPackage: iconFontPackage,
//      matchTextDirection: true);
//
//  static const IconData right_chevron = IconData(0xf3d3,
//      fontFamily: iconFont,
//      fontPackage: iconFontPackage,
//      matchTextDirection: true);
//
//  static const IconData share =
//      IconData(0xf4ca, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData share_solid =
//      IconData(0xf4cb, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData book =
//      IconData(0xf3e7, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData book_solid =
//      IconData(0xf3e8, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData bookmark =
//      IconData(0xf3e9, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData bookmark_solid =
//      IconData(0xf3ea, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData info =
//      IconData(0xf44c, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData reply =
//      IconData(0xf4c6, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData conversation_bubble =
//      IconData(0xf3fb, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData profile_circled =
//      IconData(0xf419, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData plus_circled =
//      IconData(0xf48a, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData minus_circled =
//      IconData(0xf463, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData flag =
//      IconData(0xf42c, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData search =
//      IconData(0xf4a5, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData check_mark =
//      IconData(0xf3fd, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData check_mark_circled =
//      IconData(0xf3fe, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData check_mark_circled_solid =
//      IconData(0xf3ff, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData circle =
//      IconData(0xf401, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData circle_filled =
//      IconData(0xf400, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData back = IconData(0xf3cf,
//      fontFamily: iconFont,
//      fontPackage: iconFontPackage,
//      matchTextDirection: true);
//
//  static const IconData forward = IconData(0xf3d1,
//      fontFamily: iconFont,
//      fontPackage: iconFontPackage,
//      matchTextDirection: true);
//
//  static const IconData home =
//      IconData(0xf447, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData shopping_cart =
//      IconData(0xf3f7, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData ellipsis =
//      IconData(0xf46a, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData phone =
//      IconData(0xf4b8, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData phone_solid =
//      IconData(0xf4b9, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData down_arrow =
//      IconData(0xf35d, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData up_arrow =
//      IconData(0xf366, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData battery_charging =
//      IconData(0xf111, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData battery_empty =
//      IconData(0xf112, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData battery_full =
//      IconData(0xf113, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData battery_75_percent =
//      IconData(0xf114, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData battery_25_percent =
//      IconData(0xf115, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData bluetooth =
//      IconData(0xf116, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData restart =
//      IconData(0xf21c, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData reply_all =
//      IconData(0xf21d, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData reply_thick_solid =
//      IconData(0xf21e, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData share_up =
//      IconData(0xf220, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData shuffle =
//      IconData(0xf4a9, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData shuffle_medium =
//      IconData(0xf4a8, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData shuffle_thick =
//      IconData(0xf221, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData photo_camera =
//      IconData(0xf3f5, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData photo_camera_solid =
//      IconData(0xf3f6, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData video_camera =
//      IconData(0xf4cc, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData video_camera_solid =
//      IconData(0xf4cd, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData switch_camera =
//      IconData(0xf49e, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData switch_camera_solid =
//      IconData(0xf49f, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData collections =
//      IconData(0xf3c9, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData collections_solid =
//      IconData(0xf3ca, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData folder =
//      IconData(0xf434, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData folder_solid =
//      IconData(0xf435, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData folder_open =
//      IconData(0xf38a, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData delete =
//      IconData(0xf4c4, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData delete_solid =
//      IconData(0xf4c5, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData delete_simple =
//      IconData(0xf37f, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData pen =
//      IconData(0xf2bf, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData pencil =
//      IconData(0xf37e, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData create =
//      IconData(0xf417, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData create_solid =
//      IconData(0xf417, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData refresh =
//      IconData(0xf49a, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData refresh_circled =
//      IconData(0xf49b, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData refresh_circled_solid =
//      IconData(0xf49c, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData refresh_thin =
//      IconData(0xf49d, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData refresh_thick =
//      IconData(0xf3a8, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData refresh_bold =
//      IconData(0xf21c, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData clear_thick =
//      IconData(0xf2d7, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData clear_thick_circled =
//      IconData(0xf36e, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData clear =
//      IconData(0xf404, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData clear_circled =
//      IconData(0xf405, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData clear_circled_solid =
//      IconData(0xf406, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData add =
//      IconData(0xf489, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData add_circled =
//      IconData(0xf48a, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData add_circled_solid =
//      IconData(0xf48b, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData gear =
//      IconData(0xf43c, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData gear_solid =
//      IconData(0xf43d, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData gear_big =
//      IconData(0xf2f7, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData settings =
//      IconData(0xf411, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData settings_solid =
//      IconData(0xf412, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData music_note =
//      IconData(0xf46b, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData double_music_note =
//      IconData(0xf46c, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData play_arrow =
//      IconData(0xf487, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData play_arrow_solid =
//      IconData(0xf488, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData pause =
//      IconData(0xf477, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData pause_solid =
//      IconData(0xf478, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData loop =
//      IconData(0xf449, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData loop_thick =
//      IconData(0xf44a, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData volume_down =
//      IconData(0xf3b7, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData volume_mute =
//      IconData(0xf3b8, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData volume_off =
//      IconData(0xf3b9, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData volume_up =
//      IconData(0xf3ba, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData fullscreen =
//      IconData(0xf386, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData fullscreen_exit =
//      IconData(0xf37d, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData mic_off =
//      IconData(0xf45f, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData mic =
//      IconData(0xf460, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData mic_solid =
//      IconData(0xf461, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData clock =
//      IconData(0xf4be, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData clock_solid =
//      IconData(0xf4bf, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData time =
//      IconData(0xf402, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData time_solid =
//      IconData(0xf403, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData padlock =
//      IconData(0xf4c8, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData padlock_solid =
//      IconData(0xf4c9, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData eye =
//      IconData(0xf424, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData eye_solid =
//      IconData(0xf425, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData person =
//      IconData(0xf47d, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData person_solid =
//      IconData(0xf47e, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData person_add =
//      IconData(0xf47f, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData person_add_solid =
//      IconData(0xf480, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData group =
//      IconData(0xf47b, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData group_solid =
//      IconData(0xf47c, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData mail =
//      IconData(0xf422, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData mail_solid =
//      IconData(0xf423, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData location =
//      IconData(0xf455, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData location_solid =
//      IconData(0xf456, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData tag =
//      IconData(0xf48c, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData tag_solid =
//      IconData(0xf48d, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData tags =
//      IconData(0xf48e, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData tags_solid =
//      IconData(0xf48f, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData bus =
//      IconData(0xf36d, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData car =
//      IconData(0xf36f, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData car_detailed =
//      IconData(0xf2c1, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData train_style_one =
//      IconData(0xf3af, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData train_style_two =
//      IconData(0xf3b4, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData paw =
//      IconData(0xf479, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData paw_solid =
//      IconData(0xf47a, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData game_controller =
//      IconData(0xf43a, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData game_controller_solid =
//      IconData(0xf43b, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData lab_flask =
//      IconData(0xf430, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData lab_flask_solid =
//      IconData(0xf431, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData heart =
//      IconData(0xf442, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData heart_solid =
//      IconData(0xf443, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData bell =
//      IconData(0xf3e1, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData bell_solid =
//      IconData(0xf3e2, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData news =
//      IconData(0xf471, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData news_solid =
//      IconData(0xf472, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData brightness =
//      IconData(0xf4B6, fontFamily: iconFont, fontPackage: iconFontPackage);
//
//  static const IconData brightness_solid =
//      IconData(0xf4B7, fontFamily: iconFont, fontPackage: iconFontPackage);
//}
