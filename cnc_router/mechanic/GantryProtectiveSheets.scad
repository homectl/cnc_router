GANTRY_BOTTOM_LENGTH = 10000;

GANTRY_FRONT_HEIGHT = 5400; // Triangle starts here.
GANTRY_FRONT_TRIANGLE_HEIGHT = 7600; // Height of the front triangle cutout.
GANTRY_FRONT_TRIANGLE_LENGTH = 5100;

GANTRY_FRONT_NARROW_START = GANTRY_FRONT_HEIGHT + GANTRY_FRONT_TRIANGLE_HEIGHT;
GANTRY_SIDE_BOTTOM_LENGTH = GANTRY_BOTTOM_LENGTH + 3000;
GANTRY_TOP_LENGTH = GANTRY_SIDE_BOTTOM_LENGTH - GANTRY_FRONT_TRIANGLE_LENGTH;

module GantryProtectiveSheets(width, height) {
  topSheetThickness = 70;
  topSheetSpace = 1500;
  topSheetLength = GANTRY_TOP_LENGTH - topSheetSpace;
  backSheetLength = height - GANTRY_FRONT_NARROW_START + 1000;

  translate([0, GANTRY_FRONT_TRIANGLE_LENGTH - 200, GANTRY_FRONT_NARROW_START]) {
    cube([width, 200, height - GANTRY_FRONT_NARROW_START - 3800]);
  }
  translate([0, GANTRY_FRONT_TRIANGLE_LENGTH + topSheetSpace, height]) union() {
    cube([width, topSheetLength + topSheetThickness, topSheetThickness]);
    translate([0, topSheetLength, -backSheetLength]) {
      cube([width, topSheetThickness, backSheetLength]);
    }
  }
}
