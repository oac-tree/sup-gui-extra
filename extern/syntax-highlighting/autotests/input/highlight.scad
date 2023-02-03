/*Basic test file
Written by Julian Stirling, 2018
License: MIT*/


// This is a comment
x=5;
y=6;
z=5;
r=2;
for (n = [-1.5:1:1.5]){
    translate([n*x,0,0]){cubehole([x,y,z],r);}
}

module cubehole(size,holerad)
{
    $fn=28;
    difference()
    {
        cube(size,center=true);
        cylinder(size[2]+1,r=holerad,center=true);
    }
}