{ lib
, alib
, config
, pAtt
, self
, ...
}:

let
  # Functions required to make this work.
  flakePath = path: (config.home.homeDirectory + flakeRepo) + removePrefix (toString self) (toString path);
  inherit (alib) attrsFromList;
  inherit (pAtt) flakeRepo;
  inherit (lib) removePrefix;
  inherit (lib.lists) forEach;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib.filesystem) listFilesRecursive;
  # This function takes a string corrisponding to where in your home directory
  # you want the files to go, and a relative path to the directory to
  # recursively symlink the contents of.
  symlink = (to: from: attrsFromList (
    forEach (listFilesRecursive from) (file:
      let fileItSelf = removePrefix (toString from) (toString file);
      in { "${to}/${fileItSelf}".source = mkOutOfStoreSymlink ((flakePath from) + fileItSelf); }
    )
  ));
in { config = {

  home.file = attrsFromList [
    # Here you create a symlink directory by specifying the path to where you
    # want it go in your home directory and then the relative path to the
    # directory containing the files to symlink. The parthesis is needed to tell
    # Nix that this is one singular item in the list.
    (symlink
      ".config"
      ./../assets/dot-config
    )
    (symlink
      ".local/bin"
      ./../assets/local-bin
    )
    (symlink
      ".mozilla/firefox/${config.home.username}"
      ./../assets/firefox
    )
  ];

};}
