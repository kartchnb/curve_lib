# curve_lib
This is a library for OpenSCAD that curves 2D geometry.  It is primarily intended for text, but will work with any 2d geometry (e.g. circles, squares, polygons).

Currently, only curving geometry into cylindrical shapes is implemented.  Spheres and spirals may come.  Maybe.

## Usage
The `CurveLib_WrapToCylinder` function will wrap 2D geometry to a cylindrical shape.  The following parameters are supported:

* `r` or `d`

   Specifies the radius or diameter of the cylinder to wrap around (defaults to a radius of 1).

* `height`

   The height of the cylinder to wrap around (defaults to a height of 1).

* `thickness`

   The amount to extrude the 2D geometry after it has been wrapped. Positive values extrude the geometry out from the center of the cylinder, negative values extrude inward.

* `halign`

   Specifies the horizontal alignment of the 2D geometry to wrap (defaults to "left"). 
   
   "left" indicates that the left edge of the geometry lies along the Y-axis.
   
   "right" indicates that the right edge of the geometry lies along the Y-axis.
   
   "center" indicates that the geometry is centered horizontally around the Y-axis.
   
* `valign`

   Specifies the vertical alignment of the 2D geometry to wrap (defaults to "bottom").
   
   "bottom" indicates the bottom edge of the geometry lies along the X-axis.
   
   "top" indicates the top edge of the geometry lies along the X-axis.
   
   "center" indicates the geometry is centered vertically around the X-axis.
   
* hstretch

   Specifies whether the geometry should be stretched horizontally to match the perimeter of the cylinder being wrapped around (defaults to "none").
   
   "none" indicates that the geometry should be wrapped as-is and not stretched in any way.
   
   "quarter" indicates that the geometry should be stretched to a quarter of the cylinder's perimiter.
   
   "half" indicates that the geometry should be stretched to half the cylinder's perimiter.
   
   "three-quarters" indicates that the geometry should be stretched to 3/4 of the cylinder's perimiter.
   
   "full" indicates that the geometry should be stretched to the full width of the cylinder's perimiter.
   
   Alternatively, a numerical value can be passed in to this parameter.  A value of 1 is the same as "full", 0.5 is the same as "half", 0 is the same as "none", etc.  This allows fine-tuning of the stretch amount.
   
* vstretch

   Specifies whether the geometry should be stretched vertically to match the height of the cylinder being wrapped around (defaults to "none").
   
   "none" indicates that the geometry should be wrapped as-is and not stretched in any way.
   
   "full" indicates that the geometry should be stretched to the full height of the cylinder.
   
   Alternatively, a numerical value can be passed in to this parameter.  A value of 1 is the same as "full", 0 is the same as "none", and values between the two will stretch the geometry to that percentage of the cylinder's height.  This allows fine-tuning of the stretch amount.
