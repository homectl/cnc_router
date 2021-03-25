use <Gantry.scad>;

Y_POS = $t > 0.5 ? 1 - ($t - 0.5) * 2 : $t * 2;

GANTRY_BOTTOM_LENGTH = 10000;

module SideCutout(length, height) {
  union() {
    cube([440, length + 1, height], center=true);
    translate([420, 0, 0]) cube([401, length + 1, height - 390], center=true);
  }
}

module TSlot(length, width) {
  depth = width * 1.75;

  union() {
    cube([depth, length + 1, width], center=true);
    cube([width, length + 1, depth + 1], center=true);
  }
}

module Extrusion(length, slots, height=2000, slotWidth=800) {
  width = 4000 * slots;
  sideCutoutHeight = slotWidth * 1.6;
  slotDepth = slotWidth * 1.75;

  difference() {
    // Initial body of the table.
    cube([width, length, height]);
    // Right side cutout.
    translate([width - 620, length / 2, height / 2]) SideCutout(length, sideCutoutHeight);
    // Left side cutout.
    translate([620, length / 2, height / 2]) rotate([0, 180, 0]) SideCutout(length, sideCutoutHeight);
    // Top T-slots.
    for (i = [0:slots - 1]) {
      translate([width - 2000 - 4000 * i, length / 2, height - slotDepth / 2]) TSlot(length, slotWidth);
    }
    // Bottom T-slots.
    for (i = [0:slots - 2]) {
      translate([width - 4000 - 4000 * i, length / 2, slotDepth / 2]) TSlot(length, slotWidth);
    }
  }
}

module Table(length, width) {
  slots = width / 8000 - 3;
  Extrusion(length, 3);
  for (i = [0:floor(slots) - 1]) {
    translate([4000 * (3 + i * 2), 0, 0]) Extrusion(length, 2);
  }
  translate([4000 * (3 + slots * 2), 0, 0]) Extrusion(length, 3);
}

module Nut() {
  difference() {
    union() {
      cube([1280, 1600, 600], center=true);
      translate([0, 0, (600 + 400) / 2]) cube([780, 1600, 400], center=true);
    }
    cylinder(2000, 250, 250);
  }
}

module BedSide(length, thickness) {
  cube([9000, length, thickness]);
  translate([1500, 0, thickness]) {
    cube([thickness, length, 3700]);
  }
}

module Bed(height, width, length) {
  thickness = 1000;
  sideThickness = 880;

  cube([width, thickness, height]);
  translate([0, length - thickness, 0]) {
    cube([width, thickness, height]);
  }

  translate([0, thickness, 0]) {
    BedSide(length - thickness * 2, sideThickness);
    translate([width, length - thickness * 2, 0]) rotate([0, 0, 180]) {
      BedSide(length - thickness * 2, sideThickness);
    }
  }
}

module CncRouter(width, length, gantryHeight, gantryBottomThickness, gantrySideThickness, center=false) {
  gantryWidth = width + 12000;
  bedHeight = 7000;
  tableLength = length + 13600;
  tableStart = (gantryWidth - 4000 * (width / 4000)) / 2;

  centroid = center ? [-gantryWidth/2, -tableLength/2, 0] : [0, 0, 0];
  translate(centroid) {
    translate([0, 0, bedHeight - gantryBottomThickness]) {
      yAxisTravel = tableLength - GANTRY_BOTTOM_LENGTH - 2000;
      echo(str("Y Axis Travel: ", yAxisTravel));
      translate([0, 1000 + Y_POS * yAxisTravel, -100]) {
        Gantry(gantryWidth, gantryHeight, gantryBottomThickness, gantrySideThickness);
      }
      translate([tableStart, 0, gantryBottomThickness]) {
        Table(tableLength, width);
      }
    }

    translate([tableStart, 0, 0]) {
      Bed(bedHeight, width, tableLength);
    }
  }
}

CncRouter(width=40000, length=60000, gantryHeight=26800, gantryBottomThickness=1000, gantrySideThickness=1000, center=true);
/*
translate([2000, -35000, 400]) Nut();
*/

// difference() {
//   coil(r1=800, r2=150, h=9000, twists=9000 / 450);
// }
