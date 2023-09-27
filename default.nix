{ pkgs
, iosApp
, libfrontend
, appName
, productName
, displayName
, category # https://developer.apple.com/documentation/bundleresources/information_property_list/lsapplicationcategorytype
, bundleId
, iconFile # 1024x1024 png
, teamId
, marketingVersion
, currentProjectVersion
, inspectable ? false
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "obelisk-ios-xcode";
  src = ./.;
  installPhase = ''
    substituteInPlace app.xcodeproj/project.pbxproj \
      --replace "@APP_NAME@" "${appName}" \
      --replace "@PRODUCT_NAME@" "${productName}" \
      --replace "@DISPLAY_NAME@" "${displayName}" \
      --replace "@CATEGORY@" "${category}" \
      --replace "@MARKETING_VERSION@" "${marketingVersion}" \
      --replace "@CURRENT_PROJECT_VERSION@" "${currentProjectVersion}" \
      --replace "@TEAMID@" "${teamId}" \
      --replace "@BUNDLE_ID@" "${bundleId}"

    substituteInPlace app/ViewController.m \
      --replace "_webView.inspectable = NO" "_webView.inspectable = ${if inspectable then "YES" else "NO"}"

    mkdir $out
    cp -r app $out/
    mkdir -p $out/app/lib
    cp -r app.xcodeproj $out/
    cp index.html $out/
    cp -r ${iosApp}/frontend.app/static $out/
    cp -r ${iosApp}/frontend.app/config $out/
    cp ${iosApp}/frontend.app/config.files $out/
    cp ${iosApp}/frontend.app/index.html $out/
    cp ${libfrontend}/bin/libfrontend.a $out/app/lib/
    cp ${iconFile} $out/app/Assets.xcassets/AppIcon.appiconset/Icon-1024.png
  '';
}
