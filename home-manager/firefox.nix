{...} : {
  programs.firefox.enable = true;
  environment
  environment.variables = {
    MOZ_ENABLE_WAYLAND = 0;
  };
}
