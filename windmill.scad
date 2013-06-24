// template.scad
// OpenSCAD Template
// 
// Copyright (C) 2013 Christopher Roberts
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.


// Tower Parameters
tower_height   = 15;
tower_diameter = 6;
top_diameter   = 5;
roof_diameter  = 5.3;
hole_diameter  = 1.2;

// Sail parameters
sail_length    = tower_height * 0.7;
sail_width     = sail_length * 0.3;
sail_thickness = 0.3;
sail_frame     = 1.2;
hub_diameter   = 3;
hole_spindle   = 0.6;

selection     = 3; // 1 = tower, 2 = sails, 3 = print both, 4 = demo

module tower() {

    difference() {

        // Things that exist
        union() {
            cylinder( r1 = tower_diameter/2, r2 = top_diameter/2, h = tower_height );
            translate( v = [ 0, 0, tower_height] ) {
                roof();
            }

        }

        // Things to be cut out
        union() {
            translate( v = [0,0,tower_height - hole_diameter] ) {
                rotate( a = [90,0,0] ) {
                    cylinder( r = hole_diameter, h = top_diameter, $fn = 100 );
                }
            }

        }
    }

}

module roof() {

    difference() {

        // Things that exist
        union() {
            sphere( r = roof_diameter/2, $fn = 30 );

        }

        // Things that don't exist
        union() {
            translate( v = [-roof_diameter/2, -roof_diameter/2, -roof_diameter/2] ) {
                cube( size = [roof_diameter, roof_diameter, roof_diameter/2] );
            }

        }
    
    }

}

module sails() {

    difference() {

        // Things that exist
        union() {
            // Hub
            cylinder( r = hub_diameter, h = sail_frame, $fn = 100 );

            // Spindle
            cylinder( r = spindle_diameter, h = top_diameter, $fn = 100 );

            // Sail
            for (a = [0, 90, 180, 270] ) {
                rotate( a = [0, 0, a] ) {
                    translate( v = [ hub_diameter * 0.6, 0, 0 ] ) {
                        cube ( size = [ sail_length, sail_frame, sail_frame ] );
                        cube ( size = [ sail_length, sail_width, sail_thickness ] );
                    }
                }
            }

        }

        // Things that don't exist
        union() {

        }
    
    }

}

if (selection == 1) {
    tower();
}
if (selection == 2) {
    sails();
}
if (selection == 3) {
    translate( v = [-tower_height/1.5, 0, 0] ) tower();
    translate( v = [tower_height/1.5, 0, 0] )  sails();
}
if (selection == 4) {
    tower();
    translate( v = [0, -top_diameter/2 - 2.5, tower_height - hole_diameter] ) {
        rotate( a = [90, 45, 180] ) {
            sails();
        }
    }
}

// -------------------------------------------------------------------------------------------
// Commands
// -------------------------------------------------------------------------------------------

// http://en.wikibooks.org/wiki/OpenSCAD_User_Manual

// primitives
// cube(size = [1,2,3], center = true);
// sphere( r = 10, $fn=100 );
// circle( r = 10 );
// cylinder( h = 10, r = 20, $fs = 6, center = true );
// cylinder( h = 10, r1 = 10, r2 = 20, $fs = 6, center = false );
// polyhedron(points = [ [x, y, z], ... ], triangles = [ [p1, p2, p3..], ... ], convexity = N);
// polygon(points = [ [x, y], ... ], paths = [ [p1, p2, p3..], ... ], convexity = N);

// transormations
// scale(v = [x, y, z]) { ... }
// rotate(a=[0,180,0]) { ... }
// translate(v = [x, y, z]) { ... }
// mirror([ 0, 1, 0 ]) { ... }

// rounded box by combining a cube and single cylinder
// $fn=50;
// minkowski() {
//   cube([10,10,1]);
//   cylinder(r=2,h=1);
// }

// hull() {
//   translate([15,10,0]) circle(10);
//   circle(10);
// }

// linear_extrude(height=1, convexity = 1) import("tridentlogo.dxf");
// deprecated - dxf_linear_extrude(file="tridentlogo.dxf", height = 1, center = false, convexity = 10);
// deprecated - import_dxf(file="design.dxf", layer="layername", origin = [100,100], scale = 0.5);
// linear_extrude(height = 10, center = true, convexity = 10, twist = 0, $fn = 100)
// rotate_extrude(convexity = 10, $fn = 100)
// import_stl("example012.stl", convexity = 5);

// for (z = [-1, 1] ) { ... } // two iterations, z = -1, z = 1
// for (z = [ 0 : 5 ] ) { ... } // range of interations step 1
// for (z = [ 0 : 2 : 5 ] ) { ... } // range of interations step 2

// for (i = [ [ 0, 0, 0 ], [...] ] ) { ... } // range of rotations or vectors
// usage say rotate($i) or translate($i)
// if ( x > y ) { ... } else { ... }
// assign (angle = i*360/20, distance = i*10, r = i*2)

// text http://www.thingiverse.com/thing:25036
// inkscape / select all items
// objects to path
// select the object to export
// extensions / generate from path / paths to openscad

