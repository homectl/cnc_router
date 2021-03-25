use <ZAxisPlateDrilling.scad>;

use <../common/holes.scad>;

module ZAxisTopPlate(w=10000, l=12500, h=1000, stepperProtectorR=1400, rodD=820) {
  stepperInsertH = 750;
  rodY = 3000;

  difference() {
    cube([w, l, h]);

    translate([w / 2, rodY, h / 2]) {
      countersunk_hole(h=h, d=stepperInsertH, r_inner=stepperProtectorR, r_outer=4350 / 2);
      circle_mount(r_mount=stepperProtectorR + 240, r_hole=125, h=h);
      square_mount(r_mount=4700 / 2, r_hole=200, h=h);
    }

    translate([-0.5, 900, -0.5]) cube([w + 1, 300, 100]);

    translate([0, rodY, rodD / 2]) {
      translate([1700, 0, 0]) cylinder(r=600, h=rodD + 1, center=true);
      translate([w - 1700, 0, 0]) cylinder(r=600, h=rodD + 1, center=true);
    }

    ZAxisPlateDrilling(w, l, h);
  }
}

ZAxisTopPlate();
