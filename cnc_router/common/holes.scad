module countersunk_hole(h, d, r_inner, r_outer, center=true) {
  centroid = center ? [0, 0, 0] : [r_outer, r_outer, h / 2];
  translate(centroid) {
    translate([0, 0, (h - d) / 2]) cylinder(r=r_outer, h=d + 1, center=true);
    cylinder(r=r_inner, h=h + 1, center=true);
  }
}

module circle_mount(r_mount, r_hole, h) {
  translate([0, r_mount, 0]) cylinder(r=r_hole, h=h + 1, center=true);
  translate([0, -r_mount, 0]) cylinder(r=r_hole, h=h + 1, center=true);
  translate([r_mount, 0, 0]) cylinder(r=r_hole, h=h + 1, center=true);
  translate([-r_mount, 0, 0]) cylinder(r=r_hole, h=h + 1, center=true);
}

module square_mount(r_mount, r_hole, h) {
  translate([r_mount, r_mount, 0]) cylinder(r=r_hole, h=h + 1, center=true);
  translate([r_mount, -r_mount, 0]) cylinder(r=r_hole, h=h + 1, center=true);
  translate([-r_mount, r_mount, 0]) cylinder(r=r_hole, h=h + 1, center=true);
  translate([-r_mount, -r_mount, 0]) cylinder(r=r_hole, h=h + 1, center=true);
}

module mirror_drilling(axis=[1, 0, 0]) {
  children();
  mirror(axis) children();
}

module quad_drilling(axis=[0, 0, 1]) {
  children();
  mirror([1, 0, 0]) children();
  mirror(axis) {
    children();
    mirror([1, 0, 0]) children();
  }
}
