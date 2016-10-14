# FreeBasic Height Map Manager
Read .BMP grayscale heightmap files, export them as .HM and import them later to use with the manager or other programs.
The .HM files are easier to read than .BMP files so you can quickly read data from the .HM file using your own programs.

## Installation
Put the .bi in your FreeBasic include folder

## Usage
`hm_load(fileName as string) as boolean`
Loads the .BMP file into memory. Returns FALSE on failure.

`hm_destroy(hm as heightMap)`
Cleans up memory. Use this at the end of your program or when you no longer need the height map.

`hm_export(hm as heightMap, fileName as string)`
Exports the height map data. Recommended to use .HM file type.

`hm_import(hm as heightMap, fileName as string)`
Imports the .HM file.

`hm_render(hm as heightMap)`
Used for debugging. Will create a window the same size as the heightmap and render it.

`hm_getHeight(hm as heightMap, x as integer, y as integer) as ubyte`
Gets the height value at the coordinates.

`hm_setHeight(hm as heightMap, x as integer, y as integer)`
Sets the height value at the coordinates.

## Example
```markdown
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
```
