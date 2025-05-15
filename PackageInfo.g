#
# AttributeScheduler: Graph and methods to compute attribute with dependencies
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "AttributeScheduler",
Subtitle := "Graph and methods to compute attribute with dependencies",
Version := "0.1",
Date := "15/04/2025", # dd/mm/yyyy format
License := "GPL-3.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    Email := " sebastian.gutsche@gmail.com"
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Markus",
    LastName := "Baumeister",
    Email := "baumeister@momo.math.rwth-aachen.de"
  ),
],

PackageWWWHome := "https://github.com/gap-packages/AttributeScheduler",

SourceRepository := rec( Type := "git", URL := "https://github.com/gap-packages/AttributeScheduler" ),
ArchiveURL     := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),
README_URL     := Concatenation( ~.PackageWWWHome, "/README.md" ),
PackageInfoURL := Concatenation( ~.PackageWWWHome, "/PackageInfo.g" ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "AttributeScheduler",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Graph and methods to compute attribute with dependencies",
),

Dependencies := rec(
  GAP := ">= 4.6",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [ [ "GAPDoc", ">= 1.5" ] ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


