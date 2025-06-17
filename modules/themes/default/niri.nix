{...}: {
  imports = [ ../../core/wms/niri ];
  niri.theme = {
    layout = {
      gaps = 20;

      focus-ring = {
        active = { color = "rgb(70 100 148)"; };

        inactive = { color = "rgb(84 85 86)"; };
      };
    };

    overview = {};

    window-rules = [{
      clip-to-geometry = true;
      geometry-corner-radius = {
        bottom-left = 10.;
        bottom-right = 10.;
        top-left = 10.;
        top-right = 10.;
      };
    }];

    layer-rules = [];

    no-csd = true;
  };
}
