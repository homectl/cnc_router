module triangle(o_len, a_len, depth, center=false) {
  centroid = center ? [-a_len/3, -o_len/3, -depth/2] : [0, 0, 0];
  translate(centroid) linear_extrude(height=depth) {
    polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
  }
}
