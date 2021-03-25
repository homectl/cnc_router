use <GantryProtectiveSheets.scad>;
use <GantrySide.scad>;
use <XAxis.scad>;

GANTRY_BOTTOM_LENGTH = 10000;

module GantryBottom(width, thickness) {
  cube([width, GANTRY_BOTTOM_LENGTH, thickness]);
}

module Gantry(width=52000, height=26800, bottomThickness=1000, w_side=1000) {
  h_xaxis = 12500;

  GantryBottom(width, bottomThickness);
  translate([0, 0, bottomThickness]) {
    GantrySide(w_side, height);
    translate([width - w_side, 0, 0]) GantrySide(w_side, height);

    GantryProtectiveSheets(width, height);

    translate([width/2, 9000, height - h_xaxis/2 - 2000]) {
      XAxis(width - w_side * 2, h=h_xaxis);
    }
  }
}

Gantry();
