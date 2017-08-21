# Setup script for htslabel
#
# This script is part of the htslabel CPrAN plugin for Praat.
#
# The htslabel plugin is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
#
# The htslabel plugin is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with htslabel. If not, see <http://www.gnu.org/licenses/>.
#
# Copyright 2017 Christopher Shulby, Jose Joaquin Atria

## Static commands:

nocheck Add menu command:   "Objects",  "Open", "Read HTS Label file...", "", 0, "scripts/read_lab.praat"

nocheck Add action command: "TextGrid", 0, "", 0, "", 0, "Save as HTS Label File...", "", 0, "scripts/write_lab.praat"


