{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.terminal.nixvim;
in
with lib;
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];
  options.terminal.nixvim.enable = mkEnableOption "Enable nixvim";

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;

      opts = {
        number = true;
        relativenumber = true;

        shiftwidth = 2;
      };

      clipboard.providers.wl-copy.enable = true;

      keymaps = [
        # Common
        {
          action = ":w<CR>";
          key = "<S-w>";
          mode = [ "n" ];
          options = {
            silent = true;
          };
        }
        {
          action = ":q!<CR>";
          key = "<C-b>";
          mode = [
            "t"
            "n"
          ];
          options = {
            silent = true;
          };
        }
        # Floaterm
        {
          action = "<C-\\><C-n>:ToggleTerm<CR>";
          key = "<C-/>";
          mode = [
            "t"
            "n"
          ];
          options = {
            silent = true;
            noremap = true;
          };
        }
        # Neo-tree
        {
          action = "<C-\\><C-n>:Neotree<CR>";
          key = "<C-l>";
          mode = [
            "t"
            "n"
          ];
          options = {
            silent = true;
            noremap = true;
          };
        }
      ];

      plugins = {
        # I have no idea what im doing
        cmp-buffer.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-nvim-lua.enable = true;
        cmp-cmdline.enable = true;
        cmp-path.enable = true;
        luasnip.enable = true;

        presence-nvim.enable = true;
        web-devicons.enable = true;

        cmp = {
          enable = true;

          settings = {
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-e>" = "cmp.mapping.close()";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
            snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
            sources = [
              { name = "nvim_lua"; }
              { name = "nvim_lsp"; }
              { name = "cmdline"; }
              { name = "path"; }
              { name = "luasnip"; }
              { name = "buffer"; }
            ];
          };
        };

        toggleterm.enable = true;

        barbar.enable = true;

        airline.enable = true;

        alpha = {
          enable = true;
          theme = "dashboard";
        };

        neo-tree = {
          enable = true;
          closeIfLastWindow = true;
        };

        treesitter.enable = true;
        vim-surround.enable = true;

        lsp.enable = true;

        nix.enable = true;
        lsp.servers.nixd.enable = true;

        lsp.servers.rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };

        emmet.enable = true;
      };
    };
  };
}
