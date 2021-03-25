use <../common/triangle.scad>;

GANTRY_BOTTOM_LENGTH = 10000;
GANTRY_FRONT_HEIGHT = 5400; // Triangle starts here.
GANTRY_FRONT_TRIANGLE_HEIGHT = 7600; // Height of the front triangle cutout.
GANTRY_FRONT_TRIANGLE_LENGTH = 5100;

GANTRY_FRONT_NARROW_START = GANTRY_FRONT_HEIGHT + GANTRY_FRONT_TRIANGLE_HEIGHT;
GANTRY_SIDE_BOTTOM_LENGTH = GANTRY_BOTTOM_LENGTH + 3000;

module GantrySide(thickness=1000, height=26800) {
  difference() {
    cube([thickness, GANTRY_SIDE_BOTTOM_LENGTH, height]);
    translate([-0.5, -0.5, 0]) {
      translate([0, 0, GANTRY_FRONT_NARROW_START + 1]) {
        cube([thickness + 1, GANTRY_FRONT_TRIANGLE_LENGTH, height - GANTRY_FRONT_NARROW_START]);
        translate([0, 0, 1]) rotate([0, 90, 0]) {
          triangle(o_len=GANTRY_FRONT_TRIANGLE_LENGTH, a_len=GANTRY_FRONT_TRIANGLE_HEIGHT, depth=thickness + 1);
        }
      }
      
      translate([0, GANTRY_BOTTOM_LENGTH + 100 + 1, -1]) {
        cube([thickness + 1, 2900, 4500]);
      }
      translate([0, GANTRY_SIDE_BOTTOM_LENGTH + 1, 4500 - 1.5]) {
        rotate([180, 270, 0]) triangle(o_len=2900, a_len=4000, depth=thickness + 1);
      }
    }
  }
}

GantrySide();
