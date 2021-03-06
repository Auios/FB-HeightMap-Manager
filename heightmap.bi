#pragma once

#include "fbgfx.bi"
#include "file.bi"

type heightMap
    as ulong size
    as ulong w,h
    as fb.image ptr image
    as boolean isUsed
    
    as ubyte ptr height
end type

declare sub hm_destroy(hm as heightMap)
declare sub hm_render(hm as heightMap)
declare function hm_load(hm as heightMap, fileName as string) as boolean
declare function hm_getHeight(hm as heightMap, x as integer, y as integer) as ubyte
declare sub hm_setHeight(hm as heightMap, x as integer, y as integer, setValue as ubyte)
'declare sub hm_normalize(hm as heightMap)
declare sub hm_export(hm as heightMap, fileName as string)
declare sub hm_import(hm as heightMap, fileName as string)

sub hm_destroy(hm as heightMap)
    if(hm.isUsed) then
        imageDestroy(hm.image)
        hm.image = 0
        hm.isUsed = false
        hm.size = 0
        hm.w = 0
        hm.h = 0
        
        delete[] hm.height
    end if
end sub

sub hm_render(hm as heightMap)
    if(hm.isUsed) then
        with hm
            if(NOT screenPtr()) then
                screenres(.w,.h,16)
                for y as integer = 0 to .h-1
                    for x as integer = 0 to .w-1
                        dim as integer i = (y*.w)+x
                        pset(x,y),rgb(.height[i],.height[i],.height[i])
                    next x
                next y
            end if
        end with
    end if
end sub

function hm_load(hm as heightMap, fileName as string) as boolean
    dim as boolean ret = false
    dim as integer ff
    with hm
        if(len(fileName)) then 'Is there a filename in the argument param?
            if(fileExists(fileName)) then 'Does the file exist?
                if(.isUsed = false) then 'Is this struct already being used?
                    ff = freeFile()
                    open fileName for input as #ff
                    get #ff, 19, .w
                    get #ff, 23, .h
                    close #ff
                    
                    if(NOT screenPtr()) then
                        screenres(.w,.h,16)
                    end if
                    
                    .image = imageCreate(.w,.h)
                    bload fileName, .image
                    put(0,0),.image
                    
                    .isUsed = true
                    .size = .w * .h
                    
                    .height = new ubyte[.size]
                    
                    for y as integer = 0 to .h-1
                        for x as integer = 0 to .w-1
                            dim as integer index = (.w * y) + x
                            .height[index] = (point(x,y) AND 255)'/255 '<- use this is you want to have values between 0 and 1. Also change all ubytes to floats
                        next x
                    next y
                    ret = true
                end if
            end if
        end if
    end with
    return ret
end function

function hm_getHeight(hm as heightMap, x as integer, y as integer) as ubyte
    if(hm.isUsed) then
        dim as integer index = (hm.w*y)+x
        if(index < hm.size AND index >= 0) then
            return hm.height[index]
        end if
    end if
end function

sub hm_setHeight(hm as heightMap, x as integer, y as integer, setValue as ubyte)
    if(hm.isUsed) then
        if(setValue >= 0 AND setValue <= 1) then
            dim as integer index = (hm.w*y)+x
            if(index < hm.size AND index >= 0) then
                hm.height[index] = setValue
            end if
        end if
    end if
end sub

'sub hm_normalize(hm as heightMap)
'    with hm
'        if(.isUsed) then
'            dim as single lowest = 1
'            dim as single highest = 0
'            dim as single value
'            
'            for y as integer = 0 to .h-1
'                for x as integer = 0 to .w-1
'                    value = hm_getHeight(hm,x,y)
'                    lowest = iif(value<lowest,value,lowest)
'                    highest = iif(value>highest,value,highest)
'                next x
'            next y
'            
'            highest-=lowest
'            
'            for y as integer = 0 to .h-1
'                for x as integer = 0 to .w-1
'                    value = hm_getHeight(hm,x,y)
'                    value-=lowest
'                    value/=highest
'                    hm_setHeight(hm,x,y,value)
'                next x
'            next y
'        end if
'    end with
'end sub

sub hm_import(hm as heightMap, fileName as string)
    if(len(fileName)) then
        if(fileExists(fileName)) then
            if(NOT hm.isUsed) then
                with hm
                    dim as integer ff = freeFile()
                    open fileName as #ff
                        get #ff,,.size
                        get #ff,,.w
                        get #ff,,.h
                        
                        .height = new ubyte[.size]
                        
                        for i as integer = 0 to .size-1
                            get #ff,,.height[i]
                        next i
                        
                        .isUsed = true
                    close #ff
                end with
            end if
        end if
    end if
end sub

sub hm_export(hm as heightMap, fileName as string)
    if(hm.isUsed) then
        with hm
            dim as integer ff = freeFile()
            open fileName as #ff
                put #ff,,.size
                put #ff,,.w
                put #ff,,.h
                for i as integer = 0 to .size-1
                    put #ff,,.height[i]
                next i
            close #ff
        end with
    end if
end sub
