# FBNeo_Shaders
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
