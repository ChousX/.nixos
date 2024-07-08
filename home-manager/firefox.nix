{...} : {
  programs.firefox.enable = true;
  environment.variables.MOZ_ENABLE_WAYLAND = 0;
}
