# FBNeo_Shaders
Shader file after adjusting the effect.



## Video Config Suggest ##

### "Experimental" Mode ###

<pre><code>
FinalBurn Neo
    |->Video
      |->Select Blitter
        |-> Experimental
      |-> Blitter optionns
        |-> Soft algorithm
                -> Double pixels(3D hardware)
        |-> Enable Linear filtering
        |-> Enable Scanlines
        |-> Set scanlines intensity (220)
</code></pre>

### "DirectX9 Alt" Mode ###

Base Config

<pre><code>
FinalBurn Neo
    |->Video
      |->Select Blitter
        |-> DirectX9 Alt
      |->Blitter optionns
        |-> Soft algorithm
                ->Double pixels(3D hardware)
        |-> Point filtering
        |-> Linear filtering
        |-> SoftFX algorithm
</code></pre>

Config Group
<pre><code>
   Filter                                |  SoftFX
   --------------------------------------+---------------
   Point                                 |  CRT Aperture
   Point or Linear    (not Diff)         |  CRT Caligari
   Point                                 |  CRT CGWG Fast
   Point or Linear    (not Diff)         |  CRT Easy Mode
   Linear                                |  CRT Standard
   Linear                                |  CRT Bicubic
   Point or Linear                       |  CRT Retro Scanlines   ( It is only applicable to even-fold zooming)
   Point or Linear( Linear for SFC)      |  CRT CGA
</code></pre>


Recommended settings
<pre><code>
   Point filtering + CRT Aperture
   Point filtering + CRT CGWG Fast
   Point or Linear + CRT Easy Mode
   Point or Linear + CRT CGA
</code></pre>
