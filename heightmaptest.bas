#include "heightMap.bi"
#include "crt.bi"

'Disable console
'define fbc -s gui

dim as heightMap hm

'hm_load(hm,"worldgen.bmp")
'hm_export(hm,"myHeightMap.hm")
'
'hm_normalize(hm)

'hm_destroy(hm)

'print hm.size

'for y as integer = 0 to hm.h-1
'    for x as integer = 0 to hm.w-1
'        printf("Data: " & hm_getHeight(hm,x,y) & !"\n")
'    next x
'next y

hm_import(hm, "myHeightMap.hm")

hm_render(hm)

hm_destroy(hm)

sleep()