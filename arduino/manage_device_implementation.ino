#include <ArduinoJson.h>
#include <ESP8266WiFi.h>


int bottlenum = 3; 
int filledbottles = 0;
float filltime = 5;   //ΑΡΧΙΚΟΣ ΑΡΙΘΜΟΣ FILL
float timefilltime = 0;
float movetimeAvg = (677*0.0012);   //(xmovetime)ΧΡΟΝΟΣ MOVE οριζόντια // =(number of steps)*χρόνος πλήρους pulse(+τυχόν delay)
float movetime60Avg = (815*0.0012);   //(xmovetime)ΧΡΟΝΟΣ MOVE οριζόντια // =(number of steps)*χρόνος πλήρους pulse(+τυχόν delay)
int totime = 0;
int mins;
float secs;
int x = 1;              
int y = 1;
int ymax = 3;
int xmax = 3;
int ycount = 1;
int xcount = 1;
//int xmax = 3;
//int ymax = 8; 

//VALUES REFER TO DISTANCE BETWEEN BOTTLES
int xdist = 704;
int ydist = 674;

//VALUES REFER TO RETURN DISTANCE AFTER A LIMIT IS ACTIVATED
int updist = 190;
int downdist = 410;
int leftdist = 68;
int rightdist = 38;    
int up60dist = 225;    //WAS->200->205->210->OK
int down60dist = 214;  //WAS->390->350->280->200->208->OK
int left60dist = 60;   //OK
int right60dist = 90;  //WAS->42->50->60->72->80->OK

int xsteps = 0;
int ysteps = 0;

boolean buttonstate = HIGH;
boolean bottle = HIGH;
boolean fill = HIGH;      //on-off button
boolean line = HIGH;
//boolean xplim = HIGH;
//boolean xmlim = HIGH;
//boolean yplim = HIGH;
//boolean ymlim = HIGH;
boolean arrow = HIGH;
boolean answer = LOW;
float fillcount = 0;
int sec;

//const int xdir = 10;
const int xclk = 12;       
const int yclk = 14;
const int dir = 13;
const int led = 2;
const int pump = 15;
const int buzzer = 0;
const int button = 16;
const int fillbutton = 9;
const int lim =  3;

const char ssid[] = "Innovathens";      // your network SSID (name)
//const char password [] = "";   // your network password

//int status = WL_IDLE_STATUS; //status of wifi

WiFiServer server(80);


void setup()
{
   pinMode(lim, INPUT_PULLUP);
 pinMode(button, INPUT_PULLUP);   //button joystick
 pinMode(fillbutton, INPUT_PULLUP); //button on-off      -----needs external pull-up
 pinMode(A0, INPUT);         //y joystick
 pinMode(led, OUTPUT);       //led
 pinMode(pump, OUTPUT);      //pump relay
 

 pinMode(buzzer, OUTPUT);    //buzzer

 pinMode(xclk, OUTPUT);
 pinMode(yclk, OUTPUT);
 pinMode(dir, OUTPUT);
 
 digitalWrite(dir, LOW);  
 digitalWrite(pump, HIGH);  //pump relay
  // digitalWrite(led, HIGH);

 //digitalWrite(buzzer, HIGH);  //buzzer

  Serial.begin(115200);
  Serial.println();

  Serial.printf("Connecting to %s ", ssid);
  WiFi.begin(ssid);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println(" connected");

  server.begin();
  Serial.printf("Web server started, open %s in a web browser\n", WiFi.localIP().toString().c_str());
}


// prepare a web page to be send to a client (web browser)
//String prepareHtmlPage()
//{
//  String htmlPage =
//     String("HTTP/1.1 200 OK\r\n") +
//            "Content-Type: text/html\r\n" +
//            "Connection: close\r\n" +  // the connection will be closed after completion of the response
//            "Refresh: 5\r\n" +  // refresh the page automatically every 5 sec
//            "\r\n" +
//            "<!DOCTYPE HTML>" +
//            "<html>" +
//            "Analog input:  " + String(analogRead(A0)) +
//            "</html>" +
//            "\r\n";
//  return htmlPage;
//}


void loop()
{
  WiFiClient client = server.available();
  // wait for a client (web browser) to connect
  if (client)
  {
    Serial.println("\n[Client connected]");
    
    while (client.connected())
    {
      // read line by line what the client (web browser) is requesting
      if (client.available())
      {
        
        String line = client.readStringUntil('\r');
        String requestedFunction = "";
       
          Serial.println(line);
          DynamicJsonDocument doc(1024);
          deserializeJson(doc, client);

          if(doc.as<bool>()){
    digitalWrite(led, LOW);

            delay(1500);                                               
    digitalWrite(dir,LOW);                        //y axis zeroize
while(digitalRead(lim)==HIGH){
      digitalWrite(yclk,HIGH);
      delayMicroseconds(600);
      digitalWrite(yclk,LOW);
      delayMicroseconds(600);
}
    digitalWrite(dir,HIGH);
for(int l=0;l<=410;l++){
  digitalWrite(yclk,HIGH);
      delayMicroseconds(600);
      digitalWrite(yclk,LOW);
      delayMicroseconds(600);
}

                                                 //x axis zeroize


    digitalWrite(dir,LOW);                       
while(digitalRead(lim)==HIGH){
      digitalWrite(xclk,HIGH);
      delayMicroseconds(600);
      digitalWrite(xclk,LOW);
      delayMicroseconds(600);
}
    digitalWrite(dir,HIGH);
for(int x=0;x<=68;x++){
      digitalWrite(xclk,HIGH);
      delayMicroseconds(600);
      digitalWrite(xclk,LOW);
      delayMicroseconds(600);
}





                                                //--filling loop-----position1//
  
  delay(1000);
  digitalWrite(pump,LOW);
  delay(200);
  digitalWrite(pump,HIGH);
  delay(filltime*1000);
  delay(1000);
  filledbottles=filledbottles+1;
  fill==LOW;   
  //digitalWrite(led, HIGH); 
    digitalWrite(dir,HIGH);
  for(int k=0;k<=1;k++){    
    for(int i=0;i<=674;i++){
      digitalWrite(yclk,HIGH);
      delayMicroseconds(600);
      digitalWrite(yclk,LOW);
      delayMicroseconds(600);
    }  
    digitalWrite(pump,LOW);
    delay(200);
    digitalWrite(pump,HIGH);  
    delay(filltime*1000);
  }

      digitalWrite(dir,LOW);                        
for(int p=0;p<=1348;p++){
  digitalWrite(yclk,HIGH);
      delayMicroseconds(600);
      digitalWrite(yclk,LOW);
      delayMicroseconds(600);
}
delay(1000);
  digitalWrite(led, HIGH);



            
            /////////////////////////////////////////////////////////////////////////


            
          }
          
   

        
        // wait for end of client's request, that is marked with an empty line
        if (line.length() == 1 && line[0] == '\n')
        {
          Serial.println(doc.as<String>()); 
          //client.println(prepareHtmlPage());
          break;
        }
        
      }
      // Extract values
         
    }
    delay(1); // give the web browser time to receive the data

    // close the connection:
    client.stop();
    Serial.println("[Client disonnected]");
  }
}
