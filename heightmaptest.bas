#include "heightMap.bi"
#include "crt.bi"

'Disable console
'define fbc -s gui

dim as heightMap hm

hm_load(hm,"worldgen.bmp")
print 1
sleep()

screen 0
hm_render(hm)
print 2
sleep()

screen 0
hm_export(hm,"myHeightMap.hm")
hm_destroy(hm)
hm_render(hm)
print 3
sleep()

screen 0
hm_import(hm, "myHeightMap.hm")
hm_render(hm)
print 4
sleep()

hm_destroy(hm)
end(0)