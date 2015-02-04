/*Hussain Mumtaz
husmum@gatech.edu
*/

ARRAY_BASE_CORRECTION = -1;

BLACK = "Black";
WHITE = "White";
BLUE = [.31, .45, .69];
SKIN = [.90,.596,.41];

NUMBER_OF_SPINES = 25;


module base() {
	color(BLACK)
		translate([-6,0,-20])
			cylinder(h=2,r=32);
}


//Face and space for eyes
difference(){
	color(BLUE)
		sphere(r=20);
	
		sphere(r=18);
	hull(){
		translate([15,8,4])
				sphere(r=5);
		
		translate([15,-8,4])
				sphere(r=5);}}



module eyes_base() {
	color(WHITE){
		difference(){
			hull(){
				translate([14,8,4])
					sphere(r=5);
				translate([14,-8,4])
					sphere(r=5);}}

			hull(){
				translate([14,8,4])
					sphere(r=3);
				translate([14,-8,4])
					sphere(r=3);}
		}	
}

module eye(y)
{
	//Iris
	color("LimeGreen"){
		translate([18.3,y,4]) 
			{
				scale([2.0,2.0,3.0]) 
					sphere(r=1.0); 
			}}
	
	//Pupil
	color(BLACK){
		translate([19.6,y,3])
			{
				scale([1,1,2])
					sphere(r=1);
			}}

	//Light
	color(WHITE){
		translate([20.1,y-.2,2])
			{
				sphere(r=.4);
			}}
}


module eyes() {
	LEFT = 7;
	RIGHT = -7;

	eyes_base();
	eye(LEFT);
	eye(RIGHT);	
}

module spine(position_initial, number_of_spine) {
	rotation_y = 90 - number_of_spine;
	radio = 8 - number_of_spine / 3.125;

	position_x = position_initial[0] - number_of_spine / NUMBER_OF_SPINES;
	position_y = position_initial[1];
	position_z = position_initial[2] - number_of_spine;
	position = [position_x, position_y, position_z];

	color(BLUE)
		rotate([0,rotation_y,0])
			translate(position)
				cylinder(h=5,r=radio);	
}

module lock(position_initial) {
	for (i = [0:NUMBER_OF_SPINES]) {
		spine(position_initial, i);
	}
}

module hair() {
	position_locks = [[-12,0,-8],[-5,8,-8],[-5,-8,-8],[5,8,-8],[5,-8,-8],[0,0,-8]];
	number_of_locks = len(position_locks);
	
	for (i = [0:number_of_locks + ARRAY_BASE_CORRECTION]) {
		lock(position_locks[i]);
	}
}

module nose() {
	translate([20,0,0])
	difference(){
		color(BLACK)
		hull(){
			sphere(r=2);

		translate([2,0,0])
			sphere(r=2.4);}

		translate([1,0,3])
			sphere(r=2);

		translate([1,0,-3])
			sphere(r=2);} 	
}


module cheek() {
	color(SKIN)
	translate([7,0,0])
		difference(){
			sphere(r=15);

			translate([-15,-15,-15])
				cube([15,30,30]);

			rotate([0,90,0])
			translate([-15,-15,-15])
				cube([15,30,30]);

			sphere(r=13.5);

			translate([8,-7.5,6])
				sphere(r=9);

			translate([8,7.5,6])
				sphere(r=9);

			translate([15,0,2])
				sphere(r=4);}
}

module smirk() {
	color(BLACK)
	translate([-10,3,-7]){
	difference(){
	rotate([15,0,0])
	translate([30,0,0])
	scale([1,4,1])
		sphere(r=1);

	rotate([15,0,0])
	translate([30,0,1])
	scale([1,4,1])
		sphere(r=1);
	}

	difference(){
	rotate([-15,0,0])
	translate([30,3,2])
	scale([1,1,4])
		sphere(r=1);

	rotate([-15,0,0])
	translate([30,3,0])
	scale([1,1,4])
		sphere(r=1);
	}

	difference(){
	rotate([15,0,0])
	translate([30,3.5,0])
	scale([1,1,4])
		sphere(r=1);

	rotate([15,0,0])
	translate([30,3.5,2])
	scale([1,1,4])
		sphere(r=1);
	}}
}

module mouth_area() {
	cheek();
	smirk();
}

module ear_intern() {
	cylinder(h=6, r1=4, r2=0);
}

module ear_extern() {
	cylinder(h=10, r1=5, r2=0);
}

module ear() {
	color(BLUE)
	difference(){
		ear_extern();
		ear_intern();

		translate([0,-5,0])
		cube([10,10,10]);
	}

	//Inner lobes. The difference shading is eh, 
	//but it is needed to indicate the inner lobes

	color(SKIN)
		difference(){
			ear_intern();

			translate([0,-4,0])
				cube([8,8,8]);
		}
}

module ears() {
	translate([5,10,16])
		rotate([-25,0,0])
			ear();

	translate([5,-10,16])
		rotate([25,0,0])
			ear();	
}

module make_sonic_head() {
	base();
	eyes();
	nose();
	mouth_area();
	ears();
	hair();
}

make_sonic_head();