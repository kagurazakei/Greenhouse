{
  modules.programs.mpv =
    { pkgs, ... }:
    let
      wrappedMpv = pkgs.writeShellScriptBin "mpv" ''
        export __NV_PRIME_RENDER_OFFLOAD=0  # Force Intel GPU
        exec ${pkgs.mpv}/bin/mpv \
          --gpu-context=wayland \
          --vo=gpu \
          --hwdec=no \
          "$@"
      '';
      mpvWithDesktop =
        pkgs.runCommand "mpv-with-desktop"
          {
            nativeBuildInputs = [ pkgs.makeWrapper ];
          }
          ''
            mkdir -p $out/bin $out/share/applications
            ln -s ${wrappedMpv}/bin/mpv $out/bin/mpv
            cp ${pkgs.mpv}/share/applications/mpv.desktop $out/share/applications/
            substituteInPlace $out/share/applications/mpv.desktop \
              --replace "Exec=mpv" "Exec=${wrappedMpv}/bin/mpv" \
              --replace "TryExec=mpv" "TryExec=${wrappedMpv}/bin/mpv"
            if [ -d ${pkgs.mpv}/share/icons ]; then
              cp -r ${pkgs.mpv}/share/icons $out/share/
            fi
          '';
    in
    {
      environment.systemPackages = [ mpvWithDesktop ];
      xdg.mime.defaultApplications = {
        "video/*" = [ "mpv.desktop" ];
        "audio/*" = [ "mpv.desktop" ];
      };
    };
}
# Set as default video/audio player
