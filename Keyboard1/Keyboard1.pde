int x = 20,y=20;

void setup() {
  size(100, 100);
  strokeWeight(4);
} 

void draw() {  
  background(204);
  if (keyPressed == true) { // If the key is pressed
    if(key=='d')
    x++; // add 1 to x
    if(key=='a')
    x--; // add 1 to x
    if(key=='s')
    y++;
    if(key=='w')
    y--;
  } 
  line(x, y, x-60, y-60);
}
