#include "heightMap.bi"
#include "crt.bi"

'Disable console
'define fbc -s gui

dim as heightMap hm

'hm_load(hm,"worldgen.bmp")
'
'hm_normalize(hm)

'print hm.size

'for y as integer = 0 to hm.h-1
'    for x as integer = 0 to hm.w-1
'        printf("Data: " & hm_getHeight(hm,x,y) & !"\n")
'    next x
'next y

hm_import(hm, "myHeightMap.hm")

for y as integer = 0 to hm.h-1
    for x as integer = 0 to hm.w-1
        printf("Data: " & hm_getHeight(hm,x,y) & !"\n")
    next x
next y

hm_destroy(hm)

sleep()