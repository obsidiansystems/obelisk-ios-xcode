# obelisk-ios-xcode

This project allows you to generate an xcode project for an obelisk frontend. From there, you can build for various Apple devices, manage signing, and submit to the Apple App Store.

## Instructions

First, follow the [obelisk-ios-libfrontend](https://code.obsidian.systems/src/obelisk-ios-libfrontend/src/branch/main/README.md) readme to build the frontend as a library that can be imported by the xcode project.

Once you're able to build libfrontend, import this repository and invoke it like this in your Obelisk project's default.nix:

```nix
let p = project ./. ({ ... }: {
       # all your normal project arguments go here
    };
    xcode = import ./dep/obelisk-ios-xcode {
      pkgs = obelisk.nixpkgs;
      iosApp = p.ios.frontend;
      libfrontend = p.ghcIosAarch64.obelisk-ios-libfrontend;
      appName = ios.bundleName;
      productName = ios.bundleName;
      displayName = ios.bundleName;
      category = "public.app-category.entertainment";
      bundleId = ios.bundleIdentifier;
      iconFile = ./ios/Icon-1024.png;
      teamId = "8XCUU22SN2";
      marketingVersion = "1.0.0";
      currentProjectVersion = "1.0.0.1";
      inspectable = true;
      supportedOrientations = "UIInterfaceOrientationPortrait";
      supportedOrientationsIpad = "UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationPortrait";
      targetedDeviceFamily = "1,2"; # iPhone,iPad
      iphoneOSDeploymentTarget = "17.0";
      uiStatusBarStyle = "UIStatusBarStyleDefault";
    };
in p // { inherit xcode; }

```

Now in your project root directory, you can do `nix-build . -A xcode`