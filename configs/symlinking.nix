{ lib
, alib
, config
, pAtt
, ...
}:

let
  inherit (alib) attrsFromList;
  inherit (pAtt) flakePath;
  inherit (lib) removePrefix;
  inherit (lib.lists) forEach;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (lib.filesystem) listFilesRecursive;
  # This function takes a string corrisponding to where in your home directory
  # you want the files to go, and a relative path to the directory to
  # recursively symlink the contents of.
  symlink = (to: from: attrsFromList (forEach (listFilesRecursive from) (file:
  let fileItSelf = removePrefix (toString from) (toString file);
  in { "${to}/${fileItSelf}".source = mkOutOfStoreSymlink ((flakePath from) + fileItSelf); }
  )));
in { config = {

  home.file = attrsFromList [
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
