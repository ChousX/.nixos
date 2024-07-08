{environment, ...} : {
  programs.firefox.enable = true;
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 0;
  };
}
