{ pkgs
, iosApp
, libfrontend
, appName
, productName
, displayName
, category # https://developer.apple.com/documentation/bundleresources/information_property_list/lsapplicationcategorytype
, bundleId
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "obelisk-ios-xcode";
  src = ./.;
  installPhase = ''
    mkdir $out
    cp -r app $out/
    mkdir -p $out/app/lib

    substituteInPlace app.xcodeproj/project.pbxproj \
      --replace "@APP_NAME@" "${appName}" \
      --replace "@PRODUCT_NAME@" "${productName}" \
      --replace "@DISPLAY_NAME@" "${displayName}" \
      --replace "@CATEGORY@" "${category}" \
      --replace "@BUNDLE_ID@" "${bundleId}"
    cp -r app.xcodeproj $out/
    cp index.html $out/
    cp -r ${iosApp}/frontend.app/static $out/
    cp -r ${iosApp}/frontend.app/config $out/
    cp ${iosApp}/frontend.app/config.files $out/
    cp ${iosApp}/frontend.app/index.html $out/
    cp ${libfrontend}/bin/libfrontend.a $out/app/lib/
  '';
}
