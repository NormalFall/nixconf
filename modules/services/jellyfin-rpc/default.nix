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
              url = "http://192.168.1.171:8096/";
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
            images = {
              imgbb_images = true;
              enable_images = true;
            };
          };
        };
      })
    ];
  };
}
