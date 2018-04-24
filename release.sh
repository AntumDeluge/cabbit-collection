#!/bin/sh

# Script for packaging release.
#
# This script is licensed under Creative Commons Zero (CC0).

VERSION=$1

README="Name:
  Cabbit Collection
Version:
  ${VERSION}
Description:
  A collection of sprites created by, or based on the work of, Svetlana Kushnariova (Cabbit).
Licensing:
  - OpenGameArt.org Attribution (OGA BY) version 3.0 or later (see: LICENSE-OGA-BY-3.0.txt)
  - Creative Commons Attribution (CC BY) version 3.0 or later (see: LICENSE-CC-BY-3.0.txt)
Copyright/Attribution:
  Created by Svetlana Kushnariova (Cabbit) <lana-chan@yandex.ru>, diamonddmgirl, & Jordan Irwin (AntumDeluge)
Links:
  - OpenGameArt.org page: https://opengameart.org/node/79804
  - For links to Cabbit's & diamonddmgirl's submissions, see "sources.md" file.
Notes:
  - IMPORTANT: As part of Cabbit's attribution requirements, please credit her as \"Svetlana Kushnariova\"
    & include her email address: lana-chan@yandex.ru"

SOURCES="### Cabbit Collection Sources:

<table style=\"border: 0px;\">
  <tr style=\"border: 0px;\">
    <td style=\"border: 0px; vertical-align: top; text-align: center;\">
      ![Static Preview](preview.png)
    </td>
    </tr>
    <tr style=\"border: 0px;\">
    <td style=\"border: 0px; vertical-align: top; text-align: center;\">
      ![Animated Preview](preview.gif)
    </td>
  </tr>
</table>

- (OGA BY 3.0 / CC BY 3.0)
  - [24x32 Black Character Pack](https://opengameart.org/node/72198) by Cabbit & diamonddgirl
  - [24x32 characters, 16x16 tiles](https://opengameart.org/node/72969) by Cabbit
  - [24x32 Characters Lying Down](https://opengameart.org/node/72611) by Cabbit & diamonddgirl
  - [24x32 characters with faces (big pack)](https://opengameart.org/node/24823) by Cabbit
  - [24x32 heroine Lyuba (sprites, faces, pictures)](https://opengameart.org/node/50909) by Cabbit
  - [Edited and Extended 24x32 Character Pack](https://opengameart.org/node/66147) by Cabbit & diamonddgirl"

if [ ! -z "${VERSION}" ]; then
	echo "Version: ${VERSION}"

	ZIP="cabbit-${VERSION}.zip"

	if [ -f "${ZIP}" ]; then
		echo "ERROR: \"${ZIP}\" release already exists, cannot continue"
		exit 1
	fi

	if [ ! -d "TEMP" ]; then
		mkdir "TEMP"
	fi

	echo -e "${README}" > "TEMP/README.txt"
	echo -e "${SOURCES}" > "TEMP/sources.md"
	cp "LICENSE.txt" "TEMP/LICENSE-OGA-BY-3.0.txt"
	cp "docs/other-licenses/CC-BY-3.0.txt" "TEMP/LICENSE-CC-BY-3.0.txt"

	cd "art"
	zip -r "../${ZIP}" ./ -x "/originals*" "*.DS_Store" "*.db"
	cd "../TEMP"
	zip -r "../${ZIP}" ./
	cd "../"
	zip -r "${ZIP}" "CHANGES.txt" "TODO.txt" "preview.png" "preview.gif" "preview/"

	echo
	echo "Cleaning up ..."
	find "TEMP" -type f -delete
	find "TEMP" -type d -empty -delete
else
	echo "ERROR: Must specify version as first argument"
	exit 1
fi
