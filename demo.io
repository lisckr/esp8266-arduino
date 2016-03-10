int red = 30;
int green = 32 ;
int blue = 36;

int feng = 48;

int jidian = 27;

int an1 = 0;

int r1 = 1;
int r2 = 1;
int r3 = 1;
int r4 = 1;
int r5 = 1;
int r6 = 1;
int r7 = 1;
int r8 = 1;
int r9 = 1;
int r10 = 1;
int r11 = 1;




void setup()
{
  Serial.begin(9600);
  Serial2.begin(115200);
  Serial3.begin(115200);


  pinMode(red | green | blue, OUTPUT);
  pinMode(jidian, OUTPUT);


  delay(3000);
  digitalWrite(red, HIGH);
  airKiss();
  checkWifi();
  atRst();
  atMux();
  atMode();
  atStart();
  atSend();

}

void loop()
{
  webGet();
}

/***********************************************
 * check  AT+RESTORE
 * led  buzz
 *
 ***********************************************/
void rest()
{
  do {
    delay(1000);
    Serial2.flush();
    Serial.println("AT+RESTORE");
    Serial2.print("AT+RESTORE\r\n");
    delay(100);

    unsigned long start;
    boolean result;
    start = millis();
    while (millis() - start < 4000)
    {
      result = Serial2.find("OK");
      if (result)
      {
        Serial.println("                      AT+RESTORE is ok!   ");
        delay(1000);
      }
      digitalWrite(red, LOW);
      digitalWrite(blue, HIGH);
      delay(800);
      digitalWrite(blue, LOW);


      r1 = 0;
      break;
    }
  } while (r1);

}

/***********************************************
 * check anjian touch
 * led  buzz
 *
 ***********************************************/
void airKiss()
{
  delay(1200);
  unsigned long start;
  boolean result;
  start = millis();
  while (millis() - start < 4000)
  {
    an1 = analogRead(0);
    if (an1 > 900)
    {
      delay(1500);
      if (an1 > 900)
      {
        rest();
        setMode();
        setSmart(2);
        chStau();
      }
    }

  }
}


/***********************************************
* AT+RST  check wifi
* return  wifi is connect
*
***********************************************/

void checkWifi()
{
  do {
    delay(1000);
    Serial.println("AT+RST");
    Serial2.print("AT+RST\r\n");
    delay(3000);

    unsigned long start;
    boolean result;
    start = millis();
    while (millis() - start < 4000)
    {
      result = Serial2.find("WIFI GOT IP");
      if (result)
      {
        Serial.println("                   WIFI GOT IP     ");
        digitalWrite(red, LOW);
        delay(1200);
        digitalWrite(blue, HIGH);
        delay(200);
        digitalWrite(blue, LOW);
        delay(200);
        digitalWrite(blue, HIGH);
        delay(200);
        digitalWrite(blue, LOW);
        buzz(2);
        r2 = 0;
        break;
      }
    }
  } while (r2);
}

/***********************************************
* AT+CWMODE  ap mode
* set 1
*
***********************************************/
void setMode()
{
  do {
    delay(1500);
    Serial2.flush();
    Serial.println("AT+CWMODE=1");
    Serial2.print("AT+CWMODE=1\r\n");
    delay(300);

    unsigned long start;
    boolean result;
    start = millis();
    while (millis() - start < 4000)
    {
      result = Serial2.find("OK");
      if (result)
      {
        Serial.println("                   set cwmode is ok     ");
        delay(1200);
        r3 = 0;
        break;
      }
    }
  } while (r3);
}

/***********************************************
* AT+CWSMARTSTART  airkiss set
* set smart
*
***********************************************/

void setSmart(int smart)
{
  do {
    Serial2.flush();
    Serial.print("AT+CWSMARTSTART=");
    Serial.print(smart);
    Serial.print("\r\n");
    Serial2.print("AT+CWSMARTSTART=");
    Serial2.print(smart);
    Serial2.print("\r\n");
    delay(300);

    unsigned long start;
    boolean result;
    start = millis();
    while (millis() - start < 4000)
    {
      result = Serial2.find("OK");
      if (result)
      {
        for (int i = 0; i < 4; i++)
        {
          digitalWrite(blue, HIGH);
          delay(700);
          digitalWrite(blue, LOW);
          delay(700);
        }
        Serial.println("                   set SmartStart is ok     ");
        delay(1200);
        r4 = 0;
        break;
      }
    }
  } while (r4);
}

/***********************************************
* check  set mode stauts
* led  buzz
*
***********************************************/
void chStau()
{
  do {
    unsigned long start;
    boolean result;
    start = millis();
    while (millis() - start < 4000)
    {
      result = Serial2.find("WIFI GOT IP");
      if (result)
      {
        Serial.println("                   WIFI GOT IP is ok     ");
        delay(1200);
        buzz(3);
        r5 = 0;
        break;
      }
    }
  } while (r5);
}

/**********************************************
 * buzz set
 * hz ci
 *
 ***********************************************/

void buzz(int ci)
{
  while (ci--)
  {
    tone(feng, 1322);
    delay(80);
    noTone(feng);
    delay(80);
  }
}



/**********************************************
 * AT+RST
 * return OK or error
 *
 ***********************************************/
void atRst()
{
  do {
    delay(1600);
    Serial2.flush();
    Serial.println("AT+RST");
    Serial2.print("AT+RST\r\n");
    delay(100);

    unsigned long start;
    boolean result;
    start = millis();
    while (millis() - start < 5000)
    {
      result = Serial2.find("OK");
      if (result)
      {
        Serial.println("                      reset is ok!   ");
        delay(2000);
        r6 = 0;
        break;
      }
    }
  } while (r6);
}

/**********************************************
 * AT+CIPMUX=0
 * return OK or error
 *
 ***********************************************/

void atMux()
{
  do {
    delay(1600);
    Serial2.flush();
    Serial.println("AT+CIPMUX=0");
    Serial2.print("AT+CIPMUX=0\r\n");
    delay(100);

    unsigned long start;
    boolean result;
    start = millis();
    while (millis() - start < 3000)
    {
      result = Serial2.find("OK");
      if (result)
      {
        Serial.println("                      SET CIPMUX is ok!   ");
        r7 = 0;
        break;
      }
    }
  } while (r7);
}

/**********************************************
 * AT+CIPMODE=1
 * return OK or error
 *
 ***********************************************/

void atMode()
{
  do {
    delay(1000);
    Serial2.flush();
    Serial.println("AT+CIPMODE=1");
    Serial2.print("AT+CIPMODE=1\r\n");
    delay(100);

    unsigned long start;
    boolean result;
    start = millis();
    while (millis() - start < 5000)
    {
      result = Serial2.find("OK");
      if (result)
      {
        Serial.println("                      SET CIPMODE is ok!   ");
        r8 = 0;
        break;
      }
    }
  } while (r8);
}

/**********************************************
 * AT+CIPSTART
 * return OK or error
 *
 ***********************************************/

void atStart()
{
  do {
    delay(1000);
    Serial2.flush();

    Serial.print("AT+CIPSTART=");
    Serial.print("\"");
    Serial.print("TCP");
    Serial.print("\"");
    Serial.print(",");
    Serial.print("\"");
    Serial.print("xx.xx.xx.xx");
    Serial.print("\"");
    Serial.print(",");
    Serial.print("80\r\n");

    Serial2.print("AT+CIPSTART=");
    Serial2.print("\"");
    Serial2.print("TCP");
    Serial2.print("\"");
    Serial2.print(",");
    Serial2.print("\"");
    Serial2.print("xx.xx.xx.xx");
    Serial2.print("\"");
    Serial2.print(",");
    Serial2.print("80\r\n");

    delay(100);

    unsigned long start;
    boolean result;
    start = millis();
    while (millis() - start < 5000)
    {
      result = Serial2.find("OK");
      if (result)
      {
        Serial.println("                      SET CIPSTART is ok!   ");
        r9 = 0;
        break;
      }
    }
  } while (r9);
}

/**********************************************
* AT+CIPSEND
* return OK or error
*
***********************************************/

void atSend()
{
  do {
    delay(1000);
    Serial2.flush();
    Serial.println("AT+CIPSEND");
    Serial2.print("AT+CIPSEND\r\n");
    delay(100);

    unsigned long start;
    boolean result;
    start = millis();
    while (millis() - start < 5000)
    {
      result = Serial2.find("OK");
      if (result)
      {
        Serial.println("                      SET CIPSEND is ok!   ");
        r10 = 0;
        break;
      }
    }
  } while (r10);
}

/**********************************************
* web get
* web form
*
***********************************************/

void webGet()
{
  String a = "";
  char  b;
  boolean c;

  while (r11)
  {
    Serial.print("GET /site/xx HTTP/1.1\r\n");
    Serial.print("Host: www.xxx.com\r\n");
    //Serial.print("Accept: *");
    //Serial.print("/");
    //Serial.print("*\n");
    //Serial.print("Content-Length:0\n");
    //Serial.print("Connection: close\n");
    Serial.print("");

    Serial2.print("GET /site/interface1/id/1 HTTP/1.1\r\n");
    Serial2.print("Host: www.xx.com\r\n");
    //    Serial2.print("Accept: *");
    //    Serial2.print("/");
    //    Serial2.print("*\n");
    //    Serial2.print("Content-Length:0\n");
    //    Serial2.print("Connection: close\n");
    Serial2.println("");                              //import **


    while (Serial2.available())
    {

      if (Serial2.find("{"))
      {
        digitalWrite(green, HIGH);
        c = true;
        Serial.println("/*-/*/-*/-/*/-/*-/*/-/*/-*/-/*/-/*-/*/-/*/-*/-/*/-/*/-/-/-*//-*/-/*/-/*-/-");
      }

      while (c)
      {
        b = Serial2.read();
        a += b;
        if ( b == '}')
        {
          c = false;
        }
      }

      Serial.println(a);

      if (a == "M1}")                              // 3d printer   power on
      {
        Serial.println("jidian is on");
        digitalWrite(jidian, HIGH);
      }
      else if (a == "M0}")                        // 3d printer  power off
      {
        Serial.println("jidian is off");
        digitalWrite(jidian, LOW);
      }
      else if (a == "dy1}")
      {
        digitalWrite(jidian, HIGH);
        dy1();
      }
      else if (a == "dy2}")
      {
        digitalWrite(jidian, HIGH);
        dy2();
      }
      else if (a == "dy3}")
      {
        digitalWrite(jidian, HIGH);
        dy3();
      }
      else if (a == "dy4}")
      {
        digitalWrite(jidian, HIGH);
        dy4();
      }
      else if (a == "dy5}")
      {
        digitalWrite(jidian, HIGH);
        dy5();
      }
      else if (a == "dy6}")
      {
        digitalWrite(jidian, HIGH);
        dy6();
      }

    }

    a = "";

    delay(1000);
    Serial.println("5");
    delay(1000);
    Serial.println("4");
    delay(1000);
    Serial.println("3");
    delay(1000);
    Serial.println("2");
    delay(1000);
    Serial.println("1");
  }
}

/**************************************************************************************
 *   Set home site    ->>>>>   goHome
 *   return:  ok
 *   G28   Serial3
 ************************************************************************************/

void goHome()
{
  Serial3.println("G28");
}

/**************************************************************************************
 *   Set sd init    ->>>>>   sdInit
 *   return:  ok
 *   M21   Serial3
 ************************************************************************************/

void sdInit()
{
  Serial3.println("M21");
}


/**************************************************************************************
 *   Start print    ->>>>>   stPrint
 *   return:  ok
 *   M24   Serial3
 ************************************************************************************/

void stPrint()
{
  Serial3.println("M24");
}

/**************************************************************************************
 *   ex order   ->>>>>   exOrder
 *   return:  ok
 *   dy   Serial3
 ************************************************************************************/

void dy1()
{
  goHome();
  delay(15000);
  sdInit();
  delay(1500);
  Serial3.println("M23 1.gcode");
  delay(1500);
  stPrint();
}

/**************************************************************************************
 *   ex order   ->>>>>   exOrder
 *   return:  ok
 *   dy   Serial3
 ************************************************************************************/

void dy2()
{
  goHome();
  delay(15000);
  sdInit();
  delay(1500);
  Serial3.println("M23 2.gcode");
  delay(1500);
  stPrint();
}

/**************************************************************************************
 *   ex order   ->>>>>   exOrder
 *   return:  ok
 *   dy   Serial3
 ************************************************************************************/

void dy3()
{
  goHome();
  delay(15000);
  sdInit();
  delay(1500);
  Serial3.println("M23 3.gcode");
  delay(1500);
  stPrint();
}

/**************************************************************************************
 *   ex order   ->>>>>   exOrder
 *   return:  ok
 *   dy   Serial3
 ************************************************************************************/

void dy4()
{
  goHome();
  delay(15000);
  sdInit();
  delay(1500);
  Serial3.println("M23 4.gcode");
  delay(1500);
  stPrint();
}

/**************************************************************************************
 *   ex order   ->>>>>   exOrder
 *   return:  ok
 *   dy   Serial3
 ************************************************************************************/

void dy5()
{
  goHome();
  delay(15000);
  sdInit();
  delay(1500);
  Serial3.println("M23 5.gcode");
  delay(1500);
  stPrint();
}

/**************************************************************************************
 *   ex order   ->>>>>   exOrder
 *   return:  ok
 *   dy   Serial3
 ************************************************************************************/

void dy6()
{
  goHome();
  delay(15000);
  sdInit();
  delay(1500);
  Serial3.println("M23 6.gcode");
  delay(1500);
  stPrint();
}
