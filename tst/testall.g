LoadPackage("AttributeScheduler");
dirs := DirectoriesPackageLibrary("AttributeScheduler", "tst");
TestDirectory(dirs, rec(exitGAP := true));
