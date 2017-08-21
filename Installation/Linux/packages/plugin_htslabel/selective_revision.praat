# Setup script for htklabel
#
# This script is part of the htklabel CPrAN plugin for Praat.
# The latest version is available through CPrAN or at
# <http://cpran.net/plugins/htklabel>
#
# The htklabel plugin is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
#
# The htklabel plugin is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with htklabel. If not, see <http://www.gnu.org/licenses/>.
#
# Copyright 2017 Christopher Shulby, Jose Joaquin Atria
#include procedures/read.proc

form Info
    text Textgrid
    real Start
    real End
endform


if textgrid$ != ""
      runScript: "scripts/read_lab.praat", textgrid$, "yes", "yes", "yes"

     editor = 3
     editor: editor
     Select: start , end
     Zoom to selection
     endeditor
endif
