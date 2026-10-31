{ perSystem, ... }:
{
  home.packages = [ perSystem.self.rex ];

  # updates come from bumping packages/rex, not Sparkle
  targets.darwin.defaults."com.superlogical.rex".SUEnableAutomaticChecks = false;
}
