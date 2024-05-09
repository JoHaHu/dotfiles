{
  environment.persistence = {
    "/persistent" = {
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/nixos"
      ];
      files = [
        "/etc/machine-id"
      ];
    };
  };
}
