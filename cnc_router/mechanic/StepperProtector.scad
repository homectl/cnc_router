use <../common/holes.scad>;

module StepperProtectorCutout(cutoutDepth, cutoutHeight) {
  cutoutWidth = 800;

  cube([cutoutWidth, cutoutDepth, cutoutHeight - cutoutWidth], center=true);
  translate([0, 0, (cutoutHeight - cutoutWidth) / 2]) rotate([90, 0, 0]) cylinder(r=cutoutWidth / 2, h=cutoutDepth, center=true);
  translate([0, 0, -(cutoutHeight - cutoutWidth) / 2]) rotate([90, 0, 0]) cylinder(r=cutoutWidth / 2, h=cutoutDepth, center=true);
}

module StepperProtector(r, h, bearingRadius=950, bearingDepth=800) {
  cutoutDepth = 400;
  cutoutHeight = 2340;
  topHeight = 350;

  difference() {
    union() {
      translate([0, 0, (h - topHeight) / 2]) difference() {
        cylinder(r=r + 700, h=topHeight, center=true);
        circle_mount(r_mount=r + 240, r_hole=125, h=topHeight);
      }
      difference() {
        cylinder(r=r, h=h, center=true);
        translate([0, -(r - cutoutDepth / 2), (h - cutoutHeight) / 2 - topHeight - 250]) {
          StepperProtectorCutout(cutoutDepth, cutoutHeight);
        }
      }
    }
    translate([0, 0, bearingDepth / 2]) cylinder(r=r - 100, h=h - bearingDepth + 1, center=true);
    cylinder(r=bearingRadius, h=h + 1, center=true);
  }
}

StepperProtector(1400, 3800);
