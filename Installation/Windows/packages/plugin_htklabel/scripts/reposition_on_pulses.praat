#Allow a way for changed frontiers to be repositioned over the nearest pulse
endeditor
tG = selected("TextGrid")
pointProc = tG + 1
imoved = 0
selectObject: tG

# Process intervals
ni = Get number of intervals... 1
for i to ni
    label$[i] = Get label of interval... 1 i
endfor

for i to ni-1
    selectObject: tG
    boundary = Get end point... 1 i
    selectObject: pointProc
    nearestIndex = Get nearest index: boundary
    minNew = Get time from index: nearestIndex
    if minNew != boundary
        diff = abs (boundary - minNew)
        if diff > 0.000005
            selectObject: tG
            Remove right boundary... 1 i
            Insert boundary... 1 minNew
            imoved += 1
            for i to ni
                name$ = label$[i]
                Set interval text... 1 i 'name$'
            endfor
        endif
     endif
endfor
selectObject: tG
