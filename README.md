# plugin_htslabel
htslabel for Praat adapted for HTS users from the CPrAN plugin htklabel.

This is the README for htslabel for Praat adapted for HTS users from the CPrAN plugin htklabel.  
    

  
# plugin_htklabel  
  
A plugin for Praat to read information from a HTS label files.  
  
## Installation:  

One may chose to execute the prepackaged version of this tool with Praat version 6.29.  
To do so simply execute:  
  
"install.sh" in the shell terminal for linux or  
"install.bat" from the windows cmd prompt.  

Alternatively -- if for whatever reason the installer script fails to work --

	You will need to manually coppy the files as follows (in linux just invert the slashes):

		-Create a new folder in your "<Program Files>" directory called "Praat"
		-Copy  the Praat.exe and sendpraat.exe file to your new "<Program Files>\Praat\" directory 
		-Copy  the Praat.exe file to your Desktop if you would like to acess it from there, or 
			you may create a shortcut to it (either method works fine)
		-Open and close Praat by clicking on the executable file 
			(This will automatically create the Praat preferences dir in your user profile)
		-Copy all contents(not the folder itself) in the "packages" folder to your "<User>\Praat\" folder
		-Done!
  
## Plugin Use  
 
To Open a file:  
 
From the object window the user may open a ".lab" file by selecting Open > Read HTK Label File...  
  
After the selection a menu will appear prompting the user to include the the folder where the .lab file(s) exist(s).  
This is done to ensure that files are opened and saved in the same directory  

Afterwards the user may select a .lab file and it will be opened with its corressponding  
.wav audio file (assuming they have similar directory structures and names).  
 
To Save a file:  
  
The user may click on Save > Save as HTK Label File...  
or simply open the next label file following the same process described above --  
In this case the user will be asked to save any open TextGrids as .labs before being prompted to open the next file.  
  
Other features:  
When the TextGrid is selected in the object window (it usually will be by default), the user may:  
1. Reposition the Segmentation marks over pulse marks from the .lab file  
	this is done by clicking "Reposition in pulses..." 
	from the object window. (by default when the user saves with the file, this operation is also performed automatically)  
2. View the pulse marks loaded from the .lab file with the original audio by clicking "View Manual Pulses..."  
  
## Selective Revision  
  
todo

## Useful Keyboard Shortcuts in Praat  
  
Zoom, Play and Edit in main object window:  
  Ctrl-A: Zoom all  
  Ctrl-I: Zoom in  
  Ctrl-N: Zoom to selection  
  Ctrl-O: Zoom out  
  Alt-Arrow-right: Move to next segment  
  Alt-Arrow-left: Move to last segment  
  Tab: Play selection  
  Shift-Tab: Play window  
  Arrow-up: Select earlier  
  Arrow-down: Select later  
  Shift-Arrow-up: Move start of selection left  
  Shift-Arrow-down: Move start of selection right  
  Ctrl-Arrow-up: Move end of selection left  
  Ctrl-Arrow-down: Move end of selection right  
  Page-up: Scroll page back  
  Page-down: Scroll page forward  
  Escape: Interrupt playing  
  Return: Add boundary on selected tier  
  Alt-Backspace: Remove boundary on selected tier  
  
  
Manipulation:  
  Ctrl-P: Add pulse at cursor  
  Alt-Ctrl-P: Remove selected pulses  
  Ctrl-T: Add pitch point at cursor  
  Alt-Ctrl-T: Remove selected pitch points  
  Ctrl-2: Stylize pitch (2 semitones)  
  Ctrl-4: Interpolate quadratically (4 points)  
  
General:  
  Ctrl-C: Copy  
  Ctrl-V: Paste  
  Ctrl-X: Cut (the selected text or the selected sound)  
  Ctrl-Q: Quit  
  Ctrl-S: Save  
  Ctrl-W: Close window  
  Ctrl-Y: Redo  
  Ctrl-Z: Undo  
  
Pitch:  
  Shift-Ctrl-H: Move cursor to maximum pitch  
  Shift-Ctrl-L: Move cursor to minimum pitch  
  Ctrl-0: Move cursor to nearest zero crossing  
  Ctrl-,: Move start of selection to nearest zero crossing  
  Ctrl-.: Move end of selection to nearest zero crossing  
  F5: Get pitch  
  Ctrl-F5: Get minimum pitch  
  Shift-F5: Get maximum pitch  
  
Formants:  
  F1: Get first formant  
  F2: Get second formant  
  F3: Get third formant  
  F4: Get fourth formant  
  
Other:  
  F6: Get cursor  
  F7: Get spectral power at cursor cross  
  F8: Get intensity  
  Ctrl-F8: Get minimum intensity  
  Shift-F8: Get maximum intensity  
  
Manually Configured:  
  Alt-F12: View Manual Pulses  
  Ctrl-F12: Reposition on Pulses 
