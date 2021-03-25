module finalise(w, h, l, center, flat) {
  if (flat) {
    translate([0, 0, l]) rotate([-90, 0, 0]) children();
  } else if (center) {
    translate([-w/2, -l/2, -h/2]) children();
  } else {
    children();
  }
}
