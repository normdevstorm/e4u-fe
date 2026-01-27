#!/bin/bash

# Icon Rename Script
# This script renames SVG icons to match the expected naming convention from Figma design

ICON_DIR="/run/media/normdevstorm/data-linux/dang-cay/ĐỒ ÁN_ MUST_START_NOV_15_FEB_30/e4u_application/assets/icons/svg"

cd "$ICON_DIR" || exit

echo "Starting icon rename process..."
echo "=========================================="

# Direct renames (known mappings from file names)
echo "Renaming files with known names..."

# Media icons
[ -f "play_svgrepo.com.svg" ] && mv "play_svgrepo.com.svg" "play.svg" && echo "  ✓ play.svg"
[ -f "apple-pay_svgrepo.com.svg" ] && mv "apple-pay_svgrepo.com.svg" "apple_pay.svg" && echo "  ✓ apple_pay.svg"
[ -f "camera-plus.svg" ] && mv "camera-plus.svg" "camera_plus.svg" && echo "  ✓ camera_plus.svg"
[ -f "rewind-10-seconds-forward_svgrepo.com.svg" ] && mv "rewind-10-seconds-forward_svgrepo.com.svg" "rewind_10_seconds_forward.svg" && echo "  ✓ rewind_10_seconds_forward.svg"
[ -f "rewind-10-seconds-back_svgrepo.com.svg" ] && mv "rewind-10-seconds-back_svgrepo.com.svg" "rewind_10_seconds_back.svg" && echo "  ✓ rewind_10_seconds_back.svg"
[ -f "zoom-out.svg" ] && mv "zoom-out.svg" "zoom_out.svg" && echo "  ✓ zoom_out.svg"
[ -f "lock-keyhole-minimalistic_svgrepo.com.svg" ] && mv "lock-keyhole-minimalistic_svgrepo.com.svg" "lock_keyhole_minimalistic.svg" && echo "  ✓ lock_keyhole_minimalistic.svg"
[ -f "cc-square_svgrepo.com.svg" ] && mv "cc-square_svgrepo.com.svg" "cc_square.svg" && echo "  ✓ cc_square.svg"
[ -f "South Africa.svg" ] && mv "South Africa.svg" "south_africa.svg" && echo "  ✓ south_africa.svg"
[ -f "Others.svg" ] && mv "Others.svg" "other.svg" && echo "  ✓ other.svg"

# Move share icon from vuesax folder
if [ -f "vuesax/linear/share.svg" ]; then
  mv "vuesax/linear/share.svg" "share.svg" && echo "  ✓ share.svg"
  # Clean up empty directories
  rmdir "vuesax/linear" 2>/dev/null
  rmdir "vuesax" 2>/dev/null
fi

# Handle speaker - keep speaker.svg, remove speaker-1.svg if duplicate
if [ -f "speaker-1.svg" ] && [ -f "speaker.svg" ]; then
  rm "speaker-1.svg" && echo "  ✓ Removed duplicate speaker-1.svg"
fi

# Rename Group files (flags and other icons)
echo ""
echo "Renaming Group files..."
[ -f "Group 229.svg" ] && mv "Group 229.svg" "australia.svg" && echo "  ✓ australia.svg"
[ -f "Group 230.svg" ] && mv "Group 230.svg" "uk.svg" && echo "  ✓ uk.svg"
[ -f "Group 231.svg" ] && mv "Group 231.svg" "china.svg" && echo "  ✓ china.svg"
[ -f "Group 232.svg" ] && mv "Group 232.svg" "bangladesh.svg" && echo "  ✓ bangladesh.svg"
[ -f "Group 233.svg" ] && mv "Group 233.svg" "work_bag.svg" && echo "  ✓ work_bag.svg"
[ -f "Group-1.svg" ] && mv "Group-1.svg" "plus_sign_circle.svg" && echo "  ✓ plus_sign_circle.svg"
[ -f "Group-2.svg" ] && mv "Group-2.svg" "canada.svg" && echo "  ✓ canada.svg"
[ -f "Group-3.svg" ] && mv "Group-3.svg" "pdf_file.svg" && echo "  ✓ pdf_file.svg"
[ -f "Group.svg" ] && mv "Group.svg" "png.svg" && echo "  ✓ png.svg"

# Rename elements-*.svg files based on visual analysis
echo ""
echo "Renaming elements-*.svg files..."
[ -f "elements-1.svg" ] && mv "elements-1.svg" "search.svg" && echo "  ✓ search.svg"
[ -f "elements-2.svg" ] && mv "elements-2.svg" "square.svg" && echo "  ✓ square.svg"
[ -f "elements-3.svg" ] && mv "elements-3.svg" "plus_sign.svg" && echo "  ✓ plus_sign.svg"
[ -f "elements-4.svg" ] && mv "elements-4.svg" "message_02.svg" && echo "  ✓ message_02.svg"
[ -f "elements-5.svg" ] && mv "elements-5.svg" "setting_02.svg" && echo "  ✓ setting_02.svg"
[ -f "elements-6.svg" ] && mv "elements-6.svg" "checkmark.svg" && echo "  ✓ checkmark.svg"
[ -f "elements-7.svg" ] && mv "elements-7.svg" "thumbs_up.svg" && echo "  ✓ thumbs_up.svg"
[ -f "elements-8.svg" ] && mv "elements-8.svg" "star.svg" && echo "  ✓ star.svg"
[ -f "elements-9.svg" ] && mv "elements-9.svg" "plus_sign_circle.svg" && echo "  ✓ plus_sign_circle.svg"
[ -f "elements-10.svg" ] && mv "elements-10.svg" "cross.svg" && echo "  ✓ cross.svg"
[ -f "elements-11.svg" ] && mv "elements-11.svg" "note.svg" && echo "  ✓ note.svg"
[ -f "elements-12.svg" ] && mv "elements-12.svg" "target.svg" && echo "  ✓ target.svg"
[ -f "elements-13.svg" ] && mv "elements-13.svg" "statistics.svg" && echo "  ✓ statistics.svg"
[ -f "elements-14.svg" ] && mv "elements-14.svg" "message_02.svg" && echo "  ✓ message_02.svg (overwrote duplicate)"
[ -f "elements-15.svg" ] && mv "elements-15.svg" "pen.svg" && echo "  ✓ pen.svg"
[ -f "elements-16.svg" ] && mv "elements-16.svg" "book.svg" && echo "  ✓ book.svg"
[ -f "elements-17.svg" ] && mv "elements-17.svg" "book_open_01.svg" && echo "  ✓ book_open_01.svg"
[ -f "elements-18.svg" ] && mv "elements-18.svg" "book_bookmark_02.svg" && echo "  ✓ book_bookmark_02.svg"
[ -f "elements-19.svg" ] && mv "elements-19.svg" "user_group.svg" && echo "  ✓ user_group.svg"
[ -f "elements-20.svg" ] && mv "elements-20.svg" "book.svg" && echo "  ✓ book.svg (overwrote duplicate)"
[ -f "elements-21.svg" ] && mv "elements-21.svg" "book_open_01.svg" && echo "  ✓ book_open_01.svg (overwrote duplicate)"
[ -f "elements-22.svg" ] && mv "elements-22.svg" "checkmark_circle_02.svg" && echo "  ✓ checkmark_circle_02.svg"
[ -f "elements-23.svg" ] && mv "elements-23.svg" "user_group.svg" && echo "  ✓ user_group.svg (overwrote duplicate)"
[ -f "elements-24.svg" ] && mv "elements-24.svg" "star.svg" && echo "  ✓ star.svg (overwrote duplicate)"
[ -f "elements-25.svg" ] && mv "elements-25.svg" "star_circle.svg" && echo "  ✓ star_circle.svg"
[ -f "elements-26.svg" ] && mv "elements-26.svg" "sun.svg" && echo "  ✓ sun.svg"
[ -f "elements-27.svg" ] && mv "elements-27.svg" "checkmark_badge_02.svg" && echo "  ✓ checkmark_badge_02.svg"
[ -f "elements-28.svg" ] && mv "elements-28.svg" "image_02.svg" && echo "  ✓ image_02.svg"
[ -f "elements-29.svg" ] && mv "elements-29.svg" "voice.svg" && echo "  ✓ voice.svg"
[ -f "elements-30.svg" ] && mv "elements-30.svg" "book_open_01.svg" && echo "  ✓ book_open_01.svg (overwrote duplicate)"
[ -f "elements-31.svg" ] && mv "elements-31.svg" "user.svg" && echo "  ✓ user.svg"
[ -f "elements-32.svg" ] && mv "elements-32.svg" "download_01.svg" && echo "  ✓ download_01.svg"
[ -f "elements-33.svg" ] && mv "elements-33.svg" "heart.svg" && echo "  ✓ heart.svg"
[ -f "elements-34.svg" ] && mv "elements-34.svg" "note.svg" && echo "  ✓ note.svg (overwrote duplicate)"
[ -f "elements-35.svg" ] && mv "elements-35.svg" "mortarboard_02.svg" && echo "  ✓ mortarboard_02.svg"
[ -f "elements-36.svg" ] && mv "elements-36.svg" "pen.svg" && echo "  ✓ pen.svg (overwrote duplicate)"
[ -f "elements-37.svg" ] && mv "elements-37.svg" "pen.svg" && echo "  ✓ pen.svg (overwrote duplicate)"
[ -f "elements-38.svg" ] && mv "elements-38.svg" "square.svg" && echo "  ✓ square.svg (overwrote duplicate)"
[ -f "elements-39.svg" ] && mv "elements-39.svg" "message_02.svg" && echo "  ✓ message_02.svg (overwrote duplicate)"
[ -f "elements-40.svg" ] && mv "elements-40.svg" "plus_sign_circle.svg" && echo "  ✓ plus_sign_circle.svg (overwrote duplicate)"
[ -f "elements-41.svg" ] && mv "elements-41.svg" "checkmark_circle_02.svg" && echo "  ✓ checkmark_circle_02.svg (overwrote duplicate)"
[ -f "elements-42.svg" ] && mv "elements-42.svg" "play.svg" && echo "  ✓ play.svg (overwrote duplicate)"
[ -f "elements-43.svg" ] && mv "elements-43.svg" "gem.svg" && echo "  ✓ gem.svg"
[ -f "elements-44.svg" ] && mv "elements-44.svg" "pause.svg" && echo "  ✓ pause.svg"
[ -f "elements-45.svg" ] && mv "elements-45.svg" "message_02.svg" && echo "  ✓ message_02.svg (overwrote duplicate)"
[ -f "elements-46.svg" ] && mv "elements-46.svg" "words.svg" && echo "  ✓ words.svg"
[ -f "elements-47.svg" ] && mv "elements-47.svg" "ai.svg" && echo "  ✓ ai.svg"
[ -f "elements-48.svg" ] && mv "elements-48.svg" "book_open_01.svg" && echo "  ✓ book_open_01.svg (overwrote duplicate)"
[ -f "elements-49.svg" ] && mv "elements-49.svg" "flag_02.svg" && echo "  ✓ flag_02.svg"
[ -f "elements-50.svg" ] && mv "elements-50.svg" "checkmark_badge_02.svg" && echo "  ✓ checkmark_badge_02.svg (overwrote duplicate)"
[ -f "elements-51.svg" ] && mv "elements-51.svg" "filter_horizontal.svg" && echo "  ✓ filter_horizontal.svg"
[ -f "elements-52.svg" ] && mv "elements-52.svg" "cross.svg" && echo "  ✓ cross.svg (overwrote duplicate)"
[ -f "elements-53.svg" ] && mv "elements-53.svg" "star.svg" && echo "  ✓ star.svg (overwrote duplicate)"
[ -f "elements-54.svg" ] && mv "elements-54.svg" "more.svg" && echo "  ✓ more.svg"
[ -f "elements-55.svg" ] && mv "elements-55.svg" "arrow_right_01_round.svg" && echo "  ✓ arrow_right_01_round.svg"
[ -f "elements-56.svg" ] && mv "elements-56.svg" "target.svg" && echo "  ✓ target.svg (overwrote duplicate)"
[ -f "elements-57.svg" ] && mv "elements-57.svg" "analytics_01.svg" && echo "  ✓ analytics_01.svg"
[ -f "elements-58.svg" ] && mv "elements-58.svg" "image_02.svg" && echo "  ✓ image_02.svg (overwrote duplicate)"
[ -f "elements-59.svg" ] && mv "elements-59.svg" "mic_02.svg" && echo "  ✓ mic_02.svg"
[ -f "elements-60.svg" ] && mv "elements-60.svg" "analytics_01.svg" && echo "  ✓ analytics_01.svg (overwrote duplicate)"
[ -f "elements-61.svg" ] && mv "elements-61.svg" "checkmark_badge_02.svg" && echo "  ✓ checkmark_badge_02.svg (overwrote duplicate)"
[ -f "elements-62.svg" ] && mv "elements-62.svg" "download_circle_02.svg" && echo "  ✓ download_circle_02.svg"
[ -f "elements-63.svg" ] && mv "elements-63.svg" "mic_02.svg" && echo "  ✓ mic_02.svg (overwrote duplicate)"
[ -f "elements-64.svg" ] && mv "elements-64.svg" "home_04.svg" && echo "  ✓ home_04.svg"
[ -f "elements-65.svg" ] && mv "elements-65.svg" "search.svg" && echo "  ✓ search.svg (overwrote duplicate)"
[ -f "elements-66.svg" ] && mv "elements-66.svg" "thumbs_down.svg" && echo "  ✓ thumbs_down.svg"
[ -f "elements-67.svg" ] && mv "elements-67.svg" "clock.svg" && echo "  ✓ clock.svg"
[ -f "elements-68.svg" ] && mv "elements-68.svg" "arrow_right_01_round.svg" && echo "  ✓ arrow_right_01_round.svg (overwrote duplicate)"
[ -f "elements-69.svg" ] && mv "elements-69.svg" "message_02.svg" && echo "  ✓ message_02.svg (overwrote duplicate)"
[ -f "elements-70.svg" ] && mv "elements-70.svg" "arrow_up_01_round.svg" && echo "  ✓ arrow_up_01_round.svg"
[ -f "elements-71.svg" ] && mv "elements-71.svg" "note.svg" && echo "  ✓ note.svg (overwrote duplicate)"
[ -f "elements-72.svg" ] && mv "elements-72.svg" "note.svg" && echo "  ✓ note.svg (overwrote duplicate)"
[ -f "elements-73.svg" ] && mv "elements-73.svg" "sent.svg" && echo "  ✓ sent.svg"
[ -f "elements-74.svg" ] && mv "elements-74.svg" "arrow_right_01_round.svg" && echo "  ✓ arrow_right_01_round.svg (overwrote duplicate)"
[ -f "elements-75.svg" ] && mv "elements-75.svg" "arrow_left_01_round.svg" && echo "  ✓ arrow_left_01_round.svg"

# Rename Vector files (arrows)
echo ""
echo "Renaming Vector files..."
[ -f "Vector.svg" ] && mv "Vector.svg" "arrow_up_01_round.svg" && echo "  ✓ arrow_up_01_round.svg (overwrote duplicate)"
[ -f "Vector-1.svg" ] && mv "Vector-1.svg" "arrow_down_01_round.svg" && echo "  ✓ arrow_down_01_round.svg"
[ -f "Vector-2.svg" ] && mv "Vector-2.svg" "arrow_left_01_round.svg" && echo "  ✓ arrow_left_01_round.svg (overwrote duplicate)"
[ -f "Vector-3.svg" ] && mv "Vector-3.svg" "arrow_right_01_round.svg" && echo "  ✓ arrow_right_01_round.svg (overwrote duplicate)"
[ -f "Vector-4.svg" ] && mv "Vector-4.svg" "arrow_up_right_01_round.svg" && echo "  ✓ arrow_up_right_01_round.svg"
[ -f "Vector-5.svg" ] && mv "Vector-5.svg" "arrow_up_01_round.svg" && echo "  ✓ arrow_up_01_round.svg (overwrote duplicate)"

echo ""
echo "=========================================="
echo "Rename process completed!"
echo ""
echo "Note: Some files were renamed to the same target name (duplicates overwritten)."
echo "The last file renamed will be the one that remains."
