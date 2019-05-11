import processing.serial.*;

Serial myPort;  //the Serial port object
String val;
// since we're doing serial handshaking, 
// we need to check if we've heard from the microcontroller
boolean firstContact = false;

int rectX_thrst, rectY_thrst;      // Position of square button
int rectX_hld, rectY_hld;      // Position of square button
int rectX_lnd, rectY_lnd;      // Position of square button
int rectX_role_r, rectY_role_r;      // Position of square button
int rectX_role_l, rectY_role_l;      // Position of square button
int rectX_ptch_fwd, rectY_ptch_fwd;      // Position of square button
int rectX_ptch_bkd, rectY_ptch_bkd;      // Position of square button
int rectX_yaw_cw, rectY_yaw_cw;      // Position of square button
int rectX_yaw_ccw, rectY_yaw_ccw;      // Position of square button

int rectSize = 75;     // Diameter of rect

RectDraw thrst = new RectDraw(rectX_thrst, rectY_thrst, "Thrust");
RectDraw hld = new RectDraw(rectX_hld, rectY_hld, "Hold");
RectDraw lnd = new RectDraw(rectX_lnd, rectY_lnd, "Land");
RectDraw role_l = new RectDraw(rectX_role_r, rectY_role_r, "Role Right");
RectDraw role_r = new RectDraw(rectX_role_l, rectY_role_l, "Role left");
RectDraw ptch_fwd = new RectDraw(rectX_ptch_fwd, rectY_ptch_fwd, "Forward");
RectDraw ptch_bkd = new RectDraw(rectX_ptch_bkd, rectY_ptch_bkd, "Backward");
RectDraw yaw_cw = new RectDraw(rectX_yaw_cw, rectY_yaw_cw, "Yaw +");
RectDraw yaw_ccw = new RectDraw(rectX_yaw_ccw, rectY_yaw_ccw, "Yaw -");

void setup() {
  size(800, 520);

  thrst.posRect(1, 1);
  hld.posRect(1, 3);
  lnd.posRect(1, 5);
  role_l.posRect(3, 1);
  role_r.posRect(5, 1);
  ptch_fwd.posRect(3, 3);
  ptch_bkd.posRect(5, 3);
  yaw_cw.posRect(3, 5);
  yaw_ccw.posRect(5, 5);
  
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
}
void draw() {
  background(102);  
  thrst.drawRect();
  hld.drawRect();
  lnd.drawRect();
  role_l.drawRect();
  role_r.drawRect();
  ptch_fwd.drawRect();
  ptch_bkd.drawRect();
  yaw_cw.drawRect();
  yaw_ccw.drawRect();
}
class RectDraw
{
  int rec_x, rec_y;
  String name;
  RectDraw(int rec_x, int rec_y, String name)
  {
    this.rec_x = rec_x;
    this.rec_y = rec_y;
    this.name = name;
  }
  void drawRect()
  {
    fill(0);
    beginShape();
    rect(rec_x, rec_y, rectSize, rectSize,7);
    update();
    endShape();
  }
  void posRect(int i, int j)
  {
    rec_x = i*width/7;
    rec_y = j*height/7;
  }
  void update() {
    fill(255);
    if (mouseX >= rec_x && mouseX <= (rec_x+rectSize) && mouseY >= rec_y && mouseY <= (rec_y+rectSize))
    {
      fill(140);
      if (mousePressed == true)
      {
        myPort.write(name+";");
      }
    }
    text(name, rec_x+4, rec_y+2,rectSize-10,rectSize-10);
    textAlign(CENTER,CENTER);
    stroke(255);
  }
}
void serialEvent( Serial myPort) {
try{
//put the incoming data into a String - 
//the '\n' is our end delimiter indicating the end of a complete packet
val = myPort.readStringUntil('\n');
//make sure our data isn't empty before continuing
if (val != null) {
  //trim whitespace and formatting characters (like carriage return)
  val = trim(val);
  println(val);

  //look for our 'A' string to start the handshake
  //if it's there, clear the buffer, and send a request for data
  if (firstContact == false) {
    if (val.equals("A")) {
      myPort.clear();
    firstContact = true;
      myPort.write("A");
      println("contact");
    }
  }
  else { //if we've already established contact, keep getting and parsing data
      //println(val);
      delay(10);
    }
  }
}catch(RuntimeException e) {
    e.printStackTrace();
  }
}
