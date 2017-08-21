# This script is part of the htklabel CPrAN plugin for Praat.
# The latest version is available through CPrAN or at
# <http://cpran.net/plugins/htklabel>
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

include ../../plugin_utils/procedures/check_filename.proc
include ../../plugin_htslabel/procedures/read.proc
include ../../plugin_printf/procedures/printf.proc

# Disable printf falback mode, for faster output
printf.stdout = 1
printf.system = 0

#! ~~~ params
#! in:
#!   Save as: (sentence) The path of the file to write
#! selection:
#!   in:
#!     textgrid: 0
#! ~~~
#!
#! Write an HTS label file from a set of Praat TextGrid objects.
#!
#! The mapping done by this script is the opposite from that done by the
#! `@read_lab` procedure and the `Read HTS label file...` script in this plugin.
#! Multiple TextGrid objects will be mapped to different alternatives within
#! a single label file, and multiple interval tiers will be mapped to as many
#! levels for the corresponding alternative.
#!
#! Since only interval tiers are supported at the moment, all lines in the
#! generated label files will have start and end times.
#!
#writeInfoLine: ""

form Save as HTS label file...
#    sentence Path_to_label
    sentence Save_as
    comment  Leave paths empty for GUI selector
endform

@checkWriteFile: save_as$, "Save as HTS label file...", selected$("TextGrid") + ".lab"
output_file$ = checkWriteFile.name$

total_textgrids = numberOfSelected("TextGrid")

for t to total_textgrids
    textgrid[t] = selected("TextGrid", t)
endfor

# Generate output tables
for hypothesis to total_textgrids
    new_hypothesis = 1

    textgrid = textgrid[hypothesis]
    selectObject: textgrid
    lowest_tier = Get number of tiers
    total_intervals = Get number of intervals: lowest_tier

    output[hypothesis] = Create Table with column names: selected$("TextGrid"), 0,
        ... "start end"
    output = output[hypothesis]

    selectObject: textgrid
    for i to total_intervals
        tier = lowest_tier

        this = Get starting point: tier, i
        if i == total_intervals
            next = Get total duration
        else
            next = Get starting point: tier, i+1
        endif

        repeat
            interval = Get high interval at time: tier, this
            label$ = Get label of interval: tier, interval

            if this == 0
                boundary = 1
            else
                boundary = Get interval edge from time: tier, this
            endif

            if boundary and label$ != "" and !index_regex(label$, "\s")
                if tier == lowest_tier
                    selectObject: output
                    Append row

                    @seconds_to_mlf_time: this
                    Set numeric value: Object_'output'.nrow, "start", number(seconds_to_mlf_time.return$)

                    @seconds_to_mlf_time: next
                    Set numeric value: Object_'output'.nrow, "end", number(seconds_to_mlf_time.return$)

                    selectObject: textgrid
                endif

                selectObject: output
                col$ = "L" + string$(lowest_tier - tier + 1)
                if !do("Get column index...", col$)
                    Insert column: Object_'output'.ncol + 1, col$
                endif
                Set string value: Object_'output'.nrow, col$, label$

                selectObject: textgrid
                tier -= 1
            else
                tier = 0
            endif
        until !tier
    endfor
endfor

# Delete empty output tables
selectObject()
hypotheses = 0
max_cols = 0
for t to total_textgrids
     output = output[t]
     if Object_'output'.nrow
        hypotheses += 1
        hypothesis[hypotheses] = output
        plusObject: output
        if Object_'output'.ncol > max_cols
            max_cols = Object_'output'.ncol
            max_id   = output
        endif
     else
        removeObject: output
     endif
endfor

# Make sure all output tables have the same number
# of columns, with the same labels
for h to hypotheses
    hypothesis = hypothesis[h]
    while Object_'hypothesis'.ncol < max_cols
        selectObject: max_id
        label$ = Get column label: Object_'hypothesis'.ncol + 1

        selectObject: hypothesis
        Insert column: Object_'hypothesis'.ncol + 1, label$
    endwhile
endfor

# Calculate maximum required field widths for each field
selectObject()
for h to hypotheses
    plusObject: hypothesis[h]
endfor

fields = Append
first$ = Get column label: 1
last$  = Get column label: Object_'fields'.ncol
Formula (column range): first$, last$, "length(self$)"

# Get maximum width per field (=column)
widths = Create Table without column names: "widths", 1, Object_'fields'.ncol
for c to Object_'fields'.ncol
    selectObject: fields
    label$ = Get column label: c
    max = Get maximum: label$
    selectObject: widths
    Set column label (index): c, label$
    Set numeric value: 1, label$, max
endfor
removeObject: fields

# Write the output tables to the output file
writeFile: output_file$, ""
for h to hypotheses
     hypothesis = hypothesis[h]

     selectObject: hypothesis
      if hypotheses > 1
          appendFileLine: output_file$, "/// ", selected$("Table")
      endif

      for r to Object_'hypothesis'.nrow
          line$ = ""
          for c to Object_'hypothesis'.ncol
              field$ = Get column label: c
              width  = Object_'widths'[1, field$]

              if left$(field$) != "L"
                  width = if width < 9 then 9 else width fi
                  format$ = "%0" + string$(width) + "d"
                  value   = Object_'hypothesis'[r, field$]
                  call @:sprintf: format$, value
              else
                  format$ = "%-" + string$(width) + "s"
                  value$  = Object_'hypothesis'$[r, field$]
                  call @:sprintf: format$, "'value$'"
              endif
              line$ = line$ + sprintf.return$ + " "
          endfor
          line$ = replace_regex$(line$, "\s+$", "", 0)
          appendFileLine: output_file$, line$
      endfor

      removeObject: hypothesis
endfor
removeObject: widths

# Restore original selection
selectObject()
for t to total_textgrids
    plusObject: textgrid[t]
endfor
