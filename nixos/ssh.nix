{...}:
{
  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };
    ssh-agent.enable = true;
  };
}
