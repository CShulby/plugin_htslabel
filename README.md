This is the README for htslabel for Praat adapted for HTS users from the CPrAN plugin htklabel.
The latest version of that plugin is available through CPrAN or at <http://cpran.net/plugins/htklabel>  
  
# plugin_htslabel  
  
A plugin for Praat to read information from a HTK / HTS label file and  
Master Label Files.  


This software is 100% free to use as you please, but I do ask that you cite its use in any papers:

@software{htslabel,
  author = {Shulby, Christopher and Atria, Jose},
  title = {htslabel},
  url = {https://github.com/CShulby/plugin_htslabel},
  year = {2017}
}

## Installation:  

This plugin requires some of the existing plugins distributed through CPrAN.  
If you have the CPrAN client installed on your machine, you can install them  
plugin by typing  

    cpran install <plugin_name>  

After that, you should be able to read `.lab` files using the  
commands in the `Open` menu, and save TextGrid objects as labels using the  
commands in the `Save` menu.  

If **you do no not have the client** you can follow [these instructions][1] 
to set it up and install the plugin as above.

If **you cannot install the client**, you can still use this plugin, as long
as you manually install all of its dependencies (and their dependencies).
The full list of dependencies (pointing to their git repositories with the exact commit numbers used) is:

* [tap](https://gitlab.com/cpran/plugin_tap) Commit 77b0a72d
* [utils](https://gitlab.com/cpran/plugin_utils) Commit e5db4060
* [varargs](https://gitlab.com/cpran/plugin_varargs) Commit e18966bf
* [printf](https://gitlab.com/cpran/plugin_printf) Commit 2891ad59
* [selection](https://gitlab.com/cpran/plugin_selection) Commit f021ac2d
* [strutils](https://gitlab.com/cpran/plugin_strutils) Commit c16d1674

[1]: http://cpran.net/clients/cpran/#installation Commit 0ed94a38

The user may chose to execute the prepackaged version of this tool with Praat version 6.29.  
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
or simply open the next label file following the same process described above -- In this case the user will be asked to save any open TextGrids as .labs before being prompted to open the next file.  
  
Other features:  
When the TextGrid is selected in the object window (it usually will be by default), the user may:  
1. Reposition the Segmentation marks over pulse marks from the .lab file  
	this is done by clicking "Reposition in pulses..." from the object window. (by default when the user saves with the file, this operation is also performed automatically)  
2. View the pulse marks loaded from the .lab file with the original audio by clicking "View Manual Pulses..."  
  
## Selective Revision  
  
The user may wish top open a View & Edit Window to a specific interval to revise specific boundries manually.  In the case it is necessary to call praat from the command line using the following command:  
  
in Linux:  
sendpraat praat 'runScript: "plugin_htklabel/selective_revision.praat", "<path_to_lab>", start time in seconds, end time in seconds'  

in Windows:  
sendpraat praat "runScript: \"plugin_htklabel\selective_revision.praat\", \"<path_to_lab>\", start time in seconds, end time in seconds"  

*Note paths must be full absolute paths  
*Note Time must be in seconds with the decimal placed in the proper position  

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
  Alt-F12: Save  
  Ctrl-F12: reposition_and_show_pulses.praat 

These manually configured scripts must be included as logger scripts by opening and editor and clicking:
Query > Log settings...
then add the following lines to Log script 3 and Log script 4 respectively:

Log script 3: ~/.praat-dir/plugin_htklabel/scripts/write_lab.praat
Log script 4: ~/.praat-dir/plugin_htklabel/scripts/reposition_and_show_pulses.praat
