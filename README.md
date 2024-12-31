# FBNeo_Shaders
<pre>
Shader file after adjusting color and brightness.
It mainly solves the problem that the color of the screen is biased at the first time after setting the filter in "DirectX9 Alt" mode.
The "DirectX9 Alt" mode filter manually resizing, minimizing, and maximizing the window will make the color correct, and correcting the color deviation parameter will cause the color to be incorrect. And the texture of the filter will also change slightly.
In order to get the color correct, you need to reset the "DirectX9 Alt" mode. ( Video-> Select Blitter-> DirectX9 Alt)
"CRT Aperture" and "CRT CGWG Fast" see noticeable uneven streaks in lower resolutions, which may be due to a mismatch between the algorithm implemented by the filter and the image size, but the "CRT CGA" filter does not have such a noticeable problem.
</pre>
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
