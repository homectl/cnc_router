use <BallNut.scad>;

module XAxisBearingBlock(r_guide=1000, r_screw=800, h=12500, w=10000, center=true) {
  l = r_guide * 4;
  
  r_guide_bearing = r_guide * 1.6;

  ballBearingCutoutDepth = 1500;
  ballBearingCutoutHeight = 4500;
  ballBearingCutoutRadius = 1400;

  centroid = center ? [-w/2, -l/2, -h/2] : [0, 0, 0];
  translate(centroid) {
    difference() {
      cube([w, l, h]);
      translate([-1, l / 2, r_guide * 2 + 200]) rotate([0, 90, 0]) {
        cylinder(w + 2, r_guide_bearing, r_guide_bearing);
      }
      translate([-1, l / 2, h - (r_guide * 2 + 200)]) rotate([0, 90, 0]) {
        cylinder(w + 2, r_guide_bearing, r_guide_bearing);
      }
      // Ball bearing cutout.
      translate([w - ballBearingCutoutDepth + 1, -0.5, (h - ballBearingCutoutHeight) / 2]) {
        cube([ballBearingCutoutDepth, l + 1, ballBearingCutoutHeight]);
        translate([-(w - ballBearingCutoutDepth + 2), l / 2, ballBearingCutoutHeight / 2]) rotate([0, 90, 0]) {
          cylinder(w + 2, ballBearingCutoutRadius, ballBearingCutoutRadius);
        }
      }
    }
    translate([w - ballBearingCutoutDepth / 2, l / 2, h / 2]) rotate([0, 90, 0]) {
      BallNutRound(r=r_screw, h=ballBearingCutoutDepth);
    }
  }
}

XAxisBearingBlock();
