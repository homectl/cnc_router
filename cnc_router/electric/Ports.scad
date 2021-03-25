function W_RJ45() = 1600;

module Port_RJ45() {
  w = W_RJ45();
  l = 2100;
  h = 1350;

  difference() {
    cube([w, l, h]);
    translate([100 - 1, -100, 100]) cube([w - 200, l, h - 200]);
  }
}
