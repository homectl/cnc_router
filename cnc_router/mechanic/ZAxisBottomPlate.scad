use <ZAxisPlateDrilling.scad>;

module ZAxisBottomPlate(w=10000, l=10000, h=1000, rodD=820) {
  rodY = 3000 - 1200;
  spindleMountWidth = 1200;

  difference() {
    cube([w, l, h]);

    translate([w / 2, rodY, h / 2]) {
      cylinder(r=400, h=h + 1, center=true);
    }

    translate([0, rodY, h - rodD / 2]) {
      translate([1700, 0, 0]) cylinder(r=600, h=rodD + 1, center=true);
      translate([w - 1700, 0, 0]) cylinder(r=600, h=rodD + 1, center=true);
    }

    mirror([0, 1, 0]) translate([0, 0, h]) rotate([180, 0, 0]) ZAxisPlateDrilling(w, l, h);

    frontHoleR = 200;
    frontHoleX = spindleMountWidth + frontHoleR * 2;
    translate([frontHoleX, 0, h / 2]) rotate([90, 0, 0]) {
      cylinder(r=frontHoleR, h=2000, center=true);
    }
    translate([w - frontHoleX, 0, h / 2]) rotate([90, 0, 0]) {
      cylinder(r=frontHoleR, h=2000, center=true);
    }
  }
}

ZAxisBottomPlate();
