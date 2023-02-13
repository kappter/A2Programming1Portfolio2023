// Mr Kapptie | Nov 2022 | Calculator Project
Button[] numButtons = new Button[3];
Button[] opButtons = new Button[1];

void setup() {
  size(340, 600);
  numButtons[0] = new Button(90, 330, 60, 60, '0');
  numButtons[1] = new Button(50, 270, 60, 60, '1');
  numButtons[2] = new Button(130, 270, 60, 60, '2');
  opButtons[0] = new Button(200,444,60,60,'=');
}

void draw() {
  background(80);
  for (int i=0; i<numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].hover(mouseX, mouseY);
  }
  for (int i=0; i<opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].hover(mouseX, mouseY);
  }
}

void mousePressed() {
}

void updateDisplay() {
}

void performCalculation() {
}
