#!/bin/sh

#  headerdoc-make.sh
#  MFResManager
#
#  Created by Tristan Leblanc on 19/03/16.
#  Copyright © 2016 MooseFactory. All rights reserved.

cd Support\ Files

headerdoc2html -p -j ../MFResManager/MFResFileLogger.h -o HeaderDocs

headerdoc2html -p -j ../MFResManager/MFResGetter.h -o HeaderDocs

headerdoc2html -p -j ../MFResManager/MFKeyResGetter.h -o HeaderDocs

./appledoc.sh

cp ~/help/MooseFactory\ Software/MFResManager ~/Library/Developer/Shared/Documentation/DocSets