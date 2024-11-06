include <roundedcube.scad>

$fn=100;

module paskaruuvit(koko){
      translate([-18,7,10])rotate([0,90,0])cylinder(d=koko,h=6);
      translate([-18,54,10])rotate([0,90,0])cylinder(d=koko,h=6);
      translate([-18,7,61])rotate([0,90,0])cylinder(d=koko,h=6);
      translate([-18,54,61])rotate([0,90,0])cylinder(d=koko,h=6);
    }

module putki()
  difference(){
  cylinder(d=35+8,h=70);
  translate([0,0,-1])cylinder(d=35,h=70+3);
}

module putken_kansi(){
  difference(){
    putki();
    translate([0,-31,-1]) cube(100);
  }
  difference(){
    union(){
      translate([-4,17.5,0]) cube([4,10,70]);
      translate([-4,-27.5,0]) cube([4,10,70]);
    }
    translate([13,-30.5,0]) paskaruuvit(3);
  }
}

module purkki(){
  difference(){
    union(){
      difference(){
        roundedcube([40,60,70],radius=3);
	translate([2,2,2])roundedcube([40-4,60-4,70-4],radius=2);
	translate([25,-1,-1]) cube(80);
      }
      translate([0,2,-13])roundedcube([25,56,15],radius=3);
    }
    translate([2,4,-20])roundedcube([25-4,56-4,20],radius=2);
    translate([7,13,-11])roundedcube([10,4,20],radius=2);
    translate([11,43,-3])cylinder(d=5,h=10);
  }
  difference(){
    translate([-17,3,0]) difference(){
      cube([17,55,70]);
      translate([0,27,-1])cylinder(d=35,h=70+3);
    }
    paskaruuvit(5);
  }
  translate([2,30,35])rotate([0,90,0])
    difference(){
    cylinder(d=8,h=26);
    translate([0,0,21])cylinder(d=5,h=6);
  }
}

module purkin_kansi() {
  difference(){
    union(){
      translate([-15,2.2,2.2])
	difference(){
	roundedcube([40-4,60-4-.4,70-4-.4],radius=2);
	translate([20,-1,-1])cube(100);
	translate([-85,-1,-1])cube(100);
      }
      difference(){
	roundedcube([10,60,70],radius=3);
	translate([-96,0,0]) cube(100);
      }
    }
    translate([-2,4,4]) roundedcube([10,51,62],radius=2);
    translate([2,30,35])rotate([0,90,0]) cylinder(d=3,h=10);
    }
}


module koossa() {
purkki();
translate([30,0,0]) purkin_kansi();
translate([-26,30.5,0])putken_kansi();
}


module printtaus() {
purkki();
translate([-7,59,69]) rotate([0,180,0]) purkin_kansi();
translate([-17,77,-23]) rotate([0,90,0])putken_kansi();
}

printtaus();
