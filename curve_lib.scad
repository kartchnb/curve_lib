// Map 2D children to a cylindrical shaped
module CurveLib_WrapToCylinder(r=1, d=undef, height=1, thickness=1, halign="left", valign="bottom", hstretch="none", vstretch="none")
{
    // Determine the requested diameter
    diameter = is_undef(d) ? r*2 : d;

    // Calculate the number of segments in the cylinder
    // This is based on $fn, if it has been set to a value greater than 0
    // or $fa or $fs, whichever has the larger value for the selected diameter
    fa_segment_width = diameter * sin($fa/2);
    fa_segment_count = 360/$fa;
    fs_segment_angle = asin(diameter/$fs);
    fs_segment_count = 360/fs_segment_angle;
    segment_count = 
        $fn > 0 ? $fn :
        $fs > fa_segment_width ? fs_segment_angle :
        fa_segment_count;

    // Calculate the angular size of each segment
    segment_angle = 360/segment_count;

    // Calculate the width of each segment
    segment_width = diameter * sin(segment_angle/2);

    // Calculate the perimiter of the cylinder
    perimiter = segment_width*segment_count;

    // Determine how much to stretch the underlying geometry horizontally
    horizontal_stretch_length = 
        is_num(hstretch) ? perimiter * hstretch :
        hstretch == "full" ? perimiter :
        hstretch == "three-quarters" ? perimiter*3/4 :
        hstretch == "half" ? perimiter/2 :
        hstretch == "quarter" ? perimiter/4 :
        0;

    // Determine how much to stretch the underlying geometry vertically
    vertically_stretch_length =
        is_num(vstretch) ? height * vstretch :
        vstretch == "full" ? height :
        0;

    // Determine the horizontal offset of the segments
    segment_horizontal_offset =
        halign == "center" ? perimiter/2 :
        halign == "right" ? perimiter :
        0;

    // Determine the vertical offset of the segments
    segment_vertical_offset = 
        valign == "center" ? -height/2 :
        valign == "top" ? -height :
        0;

    // Determine how the extruded segment will be scaled along the x-axis so that it tapers toward a point at the center of the cylinder
    extrude_scale = ((diameter/2) + thickness) / (diameter/2);

    // Rotate the cylinder to be horizontal
    rotate([90, 0, 0])

    // If the geometry is centered horizontally, it needs to be rotated 180 degrees into position
    // I haven't spent the effort to figure out why this happens, but this is a quick fix
    rotate([0, halign=="center" ? 180 : 0, 0])

    // Iterate over each segment in the cylinder
    for (segment_number = [0: segment_count - 1])
    {
        // One more rotation is required if $fa or $fs are being used
        rotate([0, $fn == 0 ? -segment_angle/2 : 0, 0])
        // Rotate the extruded segment into place in the cylinder
        rotate([0, segment_angle*segment_number, 0])
        // Move the extruded segment to the edge of the cylinder
        translate([0, 0, diameter/2])
        // Rotate the extruded segment to match the cylindrical curve
        rotate([0, segment_angle/2, 0])
        // Move the left edge of the extruded segment to lie against the Y-Axis
        translate([segment_width/2, 0, 0])
        // Flip the extruded segment along the Z-axis
        mirror([0, 0, thickness < 0 ? 1 : 0])
        // Extrude the segment, tapering toward a point like a piece of pie
        linear_extrude(abs(thickness), scale=[extrude_scale, 1])
        // Grab the current segment of child geometry
        intersection()
        {
            // Position the left edge of the current segment along the Y-axis
            translate([segment_horizontal_offset - segment_width*segment_number - segment_width/2, 0])
            resize([horizontal_stretch_length, vertically_stretch_length], true)
                children();

            // Grab the current segment of geometry only
            translate([-segment_width/2, segment_vertical_offset])
                square([segment_width, height]);
        }
    }
}
