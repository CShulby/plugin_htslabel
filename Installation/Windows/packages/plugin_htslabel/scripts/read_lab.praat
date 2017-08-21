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

include ../procedures/read.proc
include ../../plugin_utils/procedures/check_filename.proc

form Read HTS label file...
    sentence Path_to_label_(optional)
    comment  Leave paths empty for GUI selectors
    boolean  Use_sound_file yes
    boolean  Discard_context yes
    boolean  Use_selective_revision no
endform

if use_selective_revision
	#bruno_seu_bosta
else
	#Check if Dir has been defined
	dir_defined = 0
	if dir_defined = 0
	    for k from 1 to 9999
		.start = numberOfSelected()
		nocheck plusObject: k
		.plus = numberOfSelected()
		nocheck minusObject: k
		.minus = numberOfSelected()

		if .plus != .minus
	    	    selectObject: k
		    type_name_s$ = selected$ ()
		    type_s$ = extractWord$ (type_name_s$, "")
		    if type_s$ == "Strings"
			firstString$ = Get string: 1

			where = startsWith (firstString$, "C")
			if where == 1
		            if dir_defined = 0
			        #dir is defined
		                dir_defined = 1
		                inDir$ = Get string: 1
		            endif
		        else

			    where = startsWith (firstString$, "/")
			    if where == 1
		                if dir_defined = 0
			            #dir is defined
		                    dir_defined = 1
		                    inDir$ = Get string: 1
		                endif
			    else
		                if dir_defined = 0
			            #Define dir
			            inDir$ = chooseDirectory$: "Choose the folder containing your .lab files"
			            dirObject = Create Strings as tokens: inDir$
		                    dir_defined = 1
		                    inDir$ = Get string: 1
		                 endif
		             endif
			endif
		    endif
		endif
	    endfor
	endif


	if dir_defined = 0
	   #Define dir
	    inDir$ = chooseDirectory$: "Choose the folder containing your .lab files"
	    dirObject = Create Strings as tokens: inDir$
	    dir_defined = 1
	    inDir$ = Get string: 1
	endif

	#Check if there is a TextGrid in the Objects Windows and see if it needs to be saved
	for i from i to 9999
	    .start = numberOfSelected()
	    nocheck plusObject: i
	    .plus = numberOfSelected()
	    nocheck minusObject: i
	    .minus = numberOfSelected()

	    if .plus = .minus
		# Object does not exist
	    else
		selectObject: i
		type_name$ = selected$ ()
		type$ = extractWord$ (type_name$, "")
		if type$ == "TextGrid"
		    beginPause:"hi"
		        comment: "Would you like to save the TextGrid in the Objects window?"
		        clicked = endPause: "Yes", "No", 2, 1
		        if clicked = 1
		            selectObject: i
		            file_name$ = selected$ ("TextGrid", 1)
		            runScript: "write_lab.praat", inDir$ + "/" + file_name$ + ".lab"
		        else
		            Remove
		        endif
		endif
	    endif
	endfor

	#Check if there are Objects in the window that need to be deleted before opening the next
	for j from j to 9999
	    .start = numberOfSelected()
	    nocheck plusObject: j
	    .plus = numberOfSelected()
	    nocheck minusObject: j
	    .minus = numberOfSelected()

	    if .plus = .minus
		# Object does not exist
	    else
		selectObject: j
		type_name_s$ = selected$ ()
		type_s$ = extractWord$ (type_name_s$, "")
		if type_s$ == "Strings"
		    firstString$ = Get string: 1
		    where = startsWith (firstString$, "/")
		    if where == 0
		        Remove
		     endif
		else
		    selectObject: j
		    Remove
		endif
	    endif
	endfor
endif

@checkFilename: path_to_label$, "Select HTS label file..."
path_to_label$ = checkFilename.name$
strings = Read Strings from raw text file: path_to_label$

#import the strings from the original lab file.

stringID = strings
numberOfStrings = Get number of strings

if use_sound_file
    #@checkFilename: path_to_audio$, "Select sound file..."
    path_to_audio$ = replace_regex$(path_to_label$, "lab", "wav", 0)
    sound = Read from file: path_to_audio$

    plusObject: strings
endif

@read_lab()

if discard_context
    nocheck minusObject: sound
    Replace interval text: 1, 0, 0, "^.*?-([^+]*?)\+.*", "\1", "Regular Expressions"
    nocheck plusObject: sound
endif

object_name= selected("TextGrid")
string_object = object_name-2
audioFile = string_object + 1
tG = string_object + 2
selectObject: audioFile
lengthOfSound = Get total duration

selectObject: tG, audioFile
View & Edit
selectObject: tG

