{inputs, ...}: {
  imports = [
    ../../core/main-user
  ];

  config = {
    mainUser.modules = [
      inputs.jellyfin-rpc.homeManagerModule
      ({config, ...}: {
        services.jellyfin-rpc = {
          enable = true;
          jellyfinSecretPath = "${config.xdg.configHome}/jellyfin-rpc/jellyfin.secret";
          imgbbSecretPath = "${config.xdg.configHome}/jellyfin-rpc/imgbb.secret";
          config = {
            jellyfin = {
              url = "http://coreserver.local:8096/";
              username = "normal";
              shows = {
                display = {
                  details_text = "🎬 S{season-padded}E{episode-padded} {sep} {title} ({year})";
                  state_text = "🎭 {genres}";
                  image_text = "🎬 S{season-padded}E{episode-padded} {sep} {title} ({year})";
                };
                separator = "•";
              };
              movies = {
                display = {
                  details_text = "🎬 {title} ({year})";
                  state_text = "🎭 {genres} {critic-score} {community-score}";
                  image_text = "🎬 {title} ({year})";
                };
                separator = "•";
              };
            };
            discord = {
              application_id = "1354614157810598110";
              image_text = "LocalMedia v{version}";
            };
            images = {
              pause_icon_image = "https://i.imgur.com/JvnNE6O.png";
              default_image = "https://i.imgur.com/4pfJAz1.png";
              imgbb_images = true;
              enable_images = true;
            };
          };
        };
      })
    ];
  };
}
