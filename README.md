# FBNeo_Shaders
Shader file after adjusting color and brightness.<br>
It primarily addresses the issue of screen color bias that occurs the first time after setting the filter in 'DirectX9 Alt' mode.<br>
In FBNEO, the 'DirectX9 Alt' mode filter necessitates manual resizing, minimizing, and maximizing of the window to resolve color issues, with possible slight texture changes noticeable. Following any window size adjustments, the color correction parameters initially set will result in incorrect colors on the screen.<br>
To obtain the correct color, you need to reset the settings to the 'DirectX9 Alt' mode. (Video -> Select Blitter -> DirectX9 Alt)<br>
At lower resolutions, 'CRT Aperture' and 'CRT CGWG Fast' filters exhibit noticeable uneven streaks, potentially due to a mismatch between the filter's algorithm and the image size. In contrast, the 'CRT CGA' filter does not have such a prominent issue.
<hr>

## Video Config Suggest ##

Base Cofig

<pre><code>
FinalBurn Neo
    |-> Video
      |-> Stretch
        |-> Correct aspect ratio
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
        |-> Soft algorithm
          |-> Double pixels(3D hardware)
        |-> Point filtering
        |-> Linear filtering
        |-> SoftFX algorithm
```

2. Config Group

```html
   Filter                                |  SoftFX
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
