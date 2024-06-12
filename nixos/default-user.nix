{...}: {
  users.users.chousx =  {
    isNormalUser = true;
    description = "A. Garrett Gelwick III";
    extraGroups = ["networkmanager" "wheel" "audio"];
    initialPassword = "password";
  };
}
