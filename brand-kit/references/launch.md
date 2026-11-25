# Launch screen and welcome scene

These are two different screens. The launch screen covers the moment the app loads, on every start, and the system controls it. The welcome scene is the app's own first screen, shown once, where the brand gets its moment.

## Launch screen, every start

Ask the user which launch screen they want, and recommend the first one. A user rejected the mark on its field on every open as "like going back in 2012".

1. **Recommended: the first screen's empty frame.** Show the screen the app opens on, with its background, bars and tab bar but no content, data or text. It fills in a moment later, so the app seems to open instantly. This is Apple's own guidance: a launch screen should look like the first screen, and it is not a branding opportunity.
2. **A plain colour.** The app's background colour alone. Use it when the first screen differs by state (signed in or not, light or dark), where an empty frame could show the wrong layout.
3. **The mark on its field.** Only if the user asks for it. If so, avoid the cut-off bust: when the mark's field matches the splash colour, its square edge vanishes and a cropped face reads as a head cut off at the neck. Use a deeper shade for the splash, or put the mark on its own circle.

Rules for all three:

- **Android shows its own splash.** On Android 12 and later the system always draws a splash first: the app icon, centred, on one colour. For options 1 and 2, set the splash background to the app's background colour and give it a transparent icon, then go straight to the first screen. Note this to the user: it departs from Google's default of showing the icon. See [platforms.md](platforms.md).
- **No text.** Apple asks for none, and nothing on it is translated.
- **Static, and fast.** An iPhone launch screen cannot animate. Any motion belongs to the app after it loads.
- **No second splash on later opens.** A branded screen after the system splash is a duplicate that Google asks apps to remove, and returning users sit through it every time. After the launch screen, go straight to the product.
- **The brand's moment is the welcome scene,** below, on the first open only.

## Welcome scene, first open only

The welcome scene is the one place where the name, the character and its world appear together, large. Show it once, on the first open after install, then never again unless the user asks.

- **The mascot in its own world.** Full body, in a lively approved pose, inside a scene drawn from the product's own story, such as where its name comes from or what it is about. Never borrow a reference's setting: one admired app's habitat on another product reads as a copy.
- **The wordmark.** The name in a chunky, rounded display face, heavier and friendlier than the interface type. Use that face for the name only, so it stays special. Keep the interface typeface everywhere else.
- **One short line** under the name: what the product does, in plain words. No feature list.
- **One way forward.** Tap anywhere, or one button, continues to the mascot story or straight to the product. Nothing to fill in.
- **Motion, once.** The mascot can enter and react once, after launch, under about a second and a half. Respect reduced motion: show the still scene.
- **Store art reuses it.** The welcome scene is also the first store screenshot and the feature graphic, so the name and the character meet there too.

## Checks

- The user chose the launch screen; by default it is the first screen's empty frame, with no logo and no text, and the Android splash is set to match.
- The welcome scene appears once, shows the name, the mascot and one line, and can be passed with one tap.
- The scene's world comes from the product's own story.
