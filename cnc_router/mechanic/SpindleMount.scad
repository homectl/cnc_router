use <../common/holes.scad>;
use <../common/triangle.scad>;

module SpindleMount(height=6000, spindleDiameter=8000, center=false) {
  border = 1000;

  spindleRadius = spindleDiameter / 2;
  diameter = spindleDiameter + border * 2;
  radius = diameter / 2;
  squarePartLength = diameter * 0.66;
  extraLength = squarePartLength / 2 + 100;
  cutoutWidth = 435;
  cutoutLength = border * 2;
  drillingOffset = 170;

  centroid = center ? [0, 0, 0] : [radius, radius, height / 2];
  translate(centroid) difference() {
    union() {
      cylinder(r=radius, h=height, center=true);
      translate([0, radius - extraLength, 0]) {
        difference() {
          cube([diameter, squarePartLength, height], center=true);

          triangleA = spindleDiameter * 0.15;
          triangleO = spindleDiameter * 0.0825;
          triangleOffset = spindleDiameter * 0.075;

          triangleX = radius - triangleA - triangleOffset;
          triangleY = squarePartLength / 2 + 0.5;
          triangleZ = height / 2 + 0.5;
          translate([triangleX, triangleY, triangleZ]) rotate([0, 180, 180]) {
            triangle(o_len=triangleO, a_len=triangleA, depth=height + 1);
          }
          translate([-triangleX, triangleY, -triangleZ]) rotate([0, 0, 180]) {
            triangle(o_len=triangleO, a_len=triangleA, depth=height + 1);
          }
          translate([0, (squarePartLength - triangleO) / 2, 0]) {
            cube([diameter - triangleA * 2 - triangleOffset * 2 + 1, triangleO + 1, height + 1], center=true);
          }
        }
      }
    }
    cylinder(r=spindleRadius, h=height + 1, center=true);

    translate([radius - cutoutLength / 2 + 1, (diameter - cutoutWidth) / 2 + 100 - diameter * 0.49, 0]) {
      cube([cutoutLength, cutoutWidth, height + 1], center=true);
    }

    // Holes for mounting the spindle mount on the Z axis plate.
    quad_drilling() translate([250 + drillingOffset - radius, 8300 / 2 - extraLength, 1000 - height / 2]) {
      rotate([90, 0, 0]) countersunk_hole(h=8300, d=8300 - 1800, r_inner=250, r_outer=400);
    }

    // Hole for tightening the spindle mount.
    clampHoleBottomDepth = 2000;
    clampHoleDepth = 3000 + clampHoleBottomDepth;
    clampHoleScrewDepth = clampHoleDepth - 400 - cutoutWidth - clampHoleBottomDepth;
    clampHoleThread = 250;
    translate([radius - clampHoleThread - drillingOffset, clampHoleBottomDepth - (clampHoleDepth - cutoutWidth) / 2, 0]) {
      rotate([90, 0, 0]) countersunk_hole(h=clampHoleDepth, d=clampHoleScrewDepth, r_inner=clampHoleThread, r_outer=400);
    }
  }
}

SpindleMount(center=true);
