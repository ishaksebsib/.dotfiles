{ pkgs, ... }: {

  environment.sessionVariables = {
		PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
  };

}
