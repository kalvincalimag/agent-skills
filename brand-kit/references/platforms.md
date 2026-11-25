# Platform rules for marks and launch screens

These rules change with each OS release. Check the linked pages before a mark ships, and record the date you checked them in the project's notes.

## iPhone and iPad

- **App icon** ([Apple HIG, App icons](https://developer.apple.com/design/human-interface-guidelines/app-icons)):
  - one square 1024 × 1024 px master, with no transparency;
  - the system applies the rounded mask, so do not draw the corners in;
  - since iOS 18 there are dark and tinted versions, and since iOS 26 clear ones. Supply a dark version, and make sure the one-colour silhouette still reads.
- **Sizes people see:** about 60 pt on the home screen, 40 pt in search, 29 pt in Settings, and 20 pt in notifications. A mark that fails at 29 pt fails every day.
- **Launch screen** ([Apple HIG, Launching](https://developer.apple.com/design/human-interface-guidelines/launching)):
  - It is a static storyboard. It cannot animate or run code ([Xcode guide](https://developer.apple.com/documentation/xcode/specifying-your-apps-launch-screen)).
  - Apple asks for no text on it, says it is not a branding opportunity, and allows a logo only when it is a fixed part of the first screen.
  - In practice: the mark, or the character, on the field colour, then a quick fade into the app. Any animation belongs to the app after launch, at most once.

## Android

- **Adaptive icon** ([adaptive icons](https://developer.android.com/develop/ui/compose/system/icon_design_adaptive)):
  - foreground and background layers of 108 × 108 dp;
  - the visible area is the inner 72 dp, and the safe zone is a 66 dp circle in the centre, because launchers apply different masks;
  - add a monochrome layer for themed icons.
- **Splash screen, Android 12 and later** ([splash screen](https://developer.android.com/develop/ui/views/launch/splash-screen)):
  - The system always shows it at start: the app icon, centred, on one background colour.
  - Without an icon background, the icon is 288 dp and must fit a 192 dp circle. With an icon background colour, it is 240 dp and must fit a 160 dp circle. An icon background lets a light circle sit behind the mark on a dark field.
  - An animated icon must be an animated vector. Google recommends 1,000 ms or less. A video or 3D animation cannot run there.
  - Google recommends against the optional bottom branding image. A second, app-drawn splash after the system one is a duplicate that Google asks apps to remove ([migration guide](https://developer.android.com/develop/ui/views/launch/splash-screen/migrate)).
- **Notification icon:** white on transparent, read from the alpha only. It needs the flat silhouette.

## Web and social

- Favicon at 32 and 16 px, an `apple-touch-icon` at 180 px, and a 512 px icon for web app manifests.
- Social profile pictures are cropped to a circle. Keep the defining trait inside the inscribed circle.

## Stores

- The store listing shows the icon beside the app's name, so the name is learned there. The icon itself needs no text.
- Store screenshots and feature graphics are where the wide lockup and the animated welcome belong.
