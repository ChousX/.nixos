{...}:
let
  local = "en_US.UTF-8";
in
{
  time = {
    timeZone = "America/New_York";
    hardwareClockInLocalTime = true;
  };

  location = {
    latitude = 43.659100;
    longitude = -70.256821;
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  i18n = {
    defaultLocale = local;
    extraLocaleSettings = {
      LC_ADDRESS = local;
      LC_IDENTIFICATION =local;
      LC_MEASUREMENT = local;
      LC_MONETARY = local;
      LC_NAME = local;
      LC_NUMERIC =local;
      LC_PAPER = local;
      LC_TELEPHONE = local;
      LC_TIME =local;
    };
  };
}
