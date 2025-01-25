# FBNeo_Shaders
Shader files after adjusting color and brightness. The original shader files is in 'base' branch.</br>
Under the 'DirectX9 Alt' mode filter, color issues that arise due to the screen resolution being inadequate for the specified scaling factor can often be temporarily alleviated by manually resizing, minimizing, and then maximizing the window.</br>
This project focuses on addressing screen color bias issues that arise when the 'DirectX9 Alt' mode filter is first applied, particularly when the window is scaled to 3x on a 1366x768 resolution monitor due to insufficient pixels for accurate color representation. The objective is to resolve these issues through the adjustment of color parameters, ensuring that the screen immediately displays more accurate color results.</br>
Reset to 'DirectX9 Alt' mode to correct for color bias after window resizing. (Video -> Select Blitter -> DirectX9 Alt)</br>
When the display resolution is insufficient for achieving integer-scale magnification of the image, the 'CRT Aperture' and 'CRT CGWG Fast' filters will exhibit noticeable uneven scan lines, whereas the 'CRT CGA' filter does not exhibit this issue.
<hr>

## Video Config Suggest ##

Base Cofig

<pre><code>
FinalBurn Neo
    |-> Video
      |-> Stretch
        |-> Correct aspect ratio
      |-> Window size (Triple or More)
</code></pre>

<hr>

### "Experimental" Mode ###

<pre><code>
FinalBurn Neo
    |-> Video
      |-> Select Blitter
        |-> Experimental
      |-> Blitter optionns
        |-> Soft algorithm
          |-> Double pixels(3D hardware)
        |-> Enable Linear filtering
        |-> Enable Scanlines
        |-> Set scanlines intensity (220)
</code></pre>

<hr>

### "DirectX9 Alt" Mode ###

```html
Put shader files into: FBNEO root folder\support\shaders\
```

1. Base Config

```html
FinalBurn Neo
    |-> Video
      |-> Select Blitter
        |-> DirectX9 Alt
      |-> Blitter optionns
        |-> SoftFX algorithm
          |-> Double pixels(3D hardware)
        |-> Point filtering
        |-> Linear filtering
        |-> HardFX algorithm
```

2. Config Group

```html
   Filter                                |  HardFX
   --------------------------------------+---------------
   Point                                 |  CRT Aperture
   Point or Linear    (not different)    |  CRT Caligari
   Point                                 |  CRT CGWG Fast
   Point or Linear    (not different)    |  CRT Easy Mode
   Linear                                |  CRT Standard
   Linear                                |  CRT Bicubic
   Point or Linear                       |  CRT Retro Scanlines (SoftFX algorithm -> Select Shader's Settings)
   Point or Linear (Linear just for SFC) |  CRT CGA  (crt_cga.fx -> ENABLE_CURVED_SCREEN -> 1 or 0 )
```

3. Recommended settings

```html
   Point filtering                     + CRT Aperture
   Point filtering                     + CRT CGWG Fast
   Point filtering or Linear filtering + CRT Easy Mode
   Point filtering or Linear filtering + CRT CGA
```
