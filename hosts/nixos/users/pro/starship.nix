{ ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      gcloud.disabled = true;
    };
  };
}
