use <../common/holes.scad>;

module ZAxisPlateDrilling(w, l, h) {
  translate([0, 0, h / 2]) {
    translate([1300, l - 600, 0]) countersunk_hole(h=h, d=500, r_inner=200, r_outer=400);
    translate([1300, l - 600 - 3000, 0]) countersunk_hole(h=h, d=500, r_inner=200, r_outer=400);
    translate([w - 1300, l - 600, 0]) countersunk_hole(h=h, d=500, r_inner=200, r_outer=400);
    translate([w - 1300, l - 600 - 3000, 0]) countersunk_hole(h=h, d=500, r_inner=200, r_outer=400);
  }
}
