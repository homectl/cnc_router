use <Ballscrew.scad>;
use <ZAxis.scad>;
use <XAxisBearingBlock.scad>;

X_POS = $t > 0.5 ? 1 - ($t - 0.5) * 2 : $t * 2;

module XAxisGuide(r_guide, r_screw, h, w) {
  w_block = 10000;
  w_range = w - w_block;
  echo(str("X Axis Travel: ", w_range));

  translate([-w_range/2 + w_range * X_POS, 0, 0]) {
    XAxisBearingBlock(r_guide, r_screw, h, w_block);
    translate([-w_block/2, -10000 + r_guide*2, -h/2 - r_guide*2]) {
      ZAxis(h, w_block);
    }
  }
}

module XAxis(w=52000, h=12500) {
  r_guide = 1000;
  r_screw = 800;
  z_guide = h / 2 - r_guide * 2 - 200;

  XAxisGuide(r_guide, r_screw, h, w);

  translate([0, 0, z_guide]) rotate([0, 90, 0]) cylinder(h=w, r=r_guide, center=true);
  translate([0, 0, -z_guide]) rotate([0, 90, 0]) cylinder(h=w, r=r_guide, center=true);
  rotate([0, 90, 0]) Ballscrew(w, r_guide, center=true);
}

XAxis();
