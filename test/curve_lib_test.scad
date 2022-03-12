/* [Text Parameters] */
Text = "Testing, Testing, 1, 2, 3";
Font = "Arial";
Text_Height = 10.001;
Horizontal_Alignment = "left"; // ["left", "right", "center"]
Vertical_Alignment = "bottom"; // ["bottom", "top", "center"]
Horizontal_Stretch = "none"; // ["none", "quarter", "half", "three-quarters", "full"]
Vertical_Stretch = "none"; // ["none", "full"]



/* [Curve Parameters] */
Curve_Diameter = 100.001;
Thickness = 1.001;



/* [Advanced Parameters] */
// The value to use for creating the model preview (lower is faster)
Preview_Quality_Value = 16;

// The value to use for creating the final model render (higher is more detailed)
Render_Quality_Value = 64;



// Include external files
include<../curve_lib.scad>



module Generate()
{
    #cylinder(d=Curve_Diameter, Text_Height);
    CurveLib_MapToCylinder(d=Curve_Diameter, height=Text_Height, thickness=Thickness, halign=Horizontal_Alignment, valign=Vertical_Alignment, hstretch=Horizontal_Stretch, vstretch=Vertical_Stretch)
    resize([0, Text_Height], true)
        text(Text, font=Font, size=Text_Height, halign=Horizontal_Alignment, valign=Vertical_Alignment);
}



// Global parameters
iota = 0.001;
$fn = $preview ? Preview_Quality_Value : Render_Quality_Value;

// Generate the model
Generate();
