use <holes.scad>;

module rounded_cube_single(w, l, h, r) {
  d = r * 2;
  
  union() {
    cube([w - d, l, h], center=true);
    cube([w, l, h - d], center=true);
    quad_drilling() translate([-w/2 + r, 0, -h/2 + r]) rotate([90, 0, 0]) cylinder(r=r, h=l, center=true);
  }
}

module rounded_cube(size, r, apply_to="x", center=true) {
  w = size[0];
  l = size[1];
  h = size[2];

  intersection() {
    if (search("x", apply_to)) {
      rounded_cube_single(w, l, h, r);
    }
    if (search("y", apply_to)) {
      rotate([0, 0, 90]) rounded_cube_single(w, l, h, r);
    }
    if (search("z", apply_to)) {
      rotate([90, 0, 0]) rounded_cube_single(w, l, h, r);
    }
  }
}

rounded_cube([100, 100, 100], r=10, apply_to="xyz", center=true);
