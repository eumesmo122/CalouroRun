class Calouro {
  int X;
  int Y;
  float numInimigos;
  PImage imagem;

  void mover(int dx, int dy) {
   
    X+=3*dx;
    
    if(X<5){
      X=5;
    }
    
     if(X>width-64){
      X=width-64;
    }
   
  }

  void desenha() {
    image(imagem, X, Y, 64, 159);
  }
}

class Inimigo {
  int X = int(random(800));
  int Y = int(random(480));
  int numInimigos;
  float velocidade = 2; 
  PImage imagem = loadImage("calculadora.png");
 
  boolean verificaColisao(Calouro c) { 

    if ((c.X<=X)&&(X<=c.X+64)) {
      if ((c.Y<=Y)&&(Y<=c.Y+159)) {
         if (pontos>recorde){ recorde=pontos; }
         pontos=0; 
         velocidade=2;
        
        return true;
      }
    }

    if ((c.X<=X+50)&&(X+50<=c.X+64)) {
      if ((c.Y<=Y+50)&&(Y+50<=c.Y+159)) {
        if (pontos>recorde){ recorde=pontos; }
        pontos=0; 
        velocidade=2;
        
        return true;
      }
    }

    if ((c.X<=X)&&(X<=c.X+64)) {
      if ((c.Y<=Y+50)&&(Y+50<=c.Y+159)) {
        if (pontos>recorde){ recorde=pontos; }
        pontos=0;  
        velocidade=2;
       
        return true;
      }
    }

    if ((c.X<=X+50)&&(X+50<=c.X+64)) {
      if ((c.Y<=Y)&&(Y<=c.Y+159)) {
        if (pontos>recorde){ recorde=pontos; }
        pontos=0; 
        velocidade=2;
        
        return true;
      }
  }

    return false;
  }
  
  void reset(){
    Y =  int(random(480));
    X = int(random(800));
  }

  void mover() {
    if (pontos==0){
    velocidade=2;
    }    
    if ((pontos>=10)&&(pontos<20)){
    velocidade=3;
    }
    if ((pontos>=20)&&(pontos<40)){
    velocidade=4;
    }
    if ((pontos>=40)&&(pontos<80)){
    velocidade=5;
    }
    if ((pontos>=80)&&(pontos<100)){
    velocidade=6;
    }
    if (pontos>=100){
    velocidade=6;
    }
    Y+=velocidade;
    if (Y > height) {
    X = int(random(800));      
      pontos++;  
      Y = -20;

    }
  }

  void desenha() {
    image(imagem, X, Y, 55, 55);
  }
}



PImage fundo;
Calouro meuCalouro = new Calouro();
ArrayList<Inimigo> listaInimigos = new ArrayList<Inimigo>();
void setup() {
  size(695, 394);
  fundo = loadImage("fundo.jpg");
  meuCalouro.imagem = loadImage("Calouro.png");
  meuCalouro.X = 50;
  meuCalouro.Y = 245;
 
}
int pontos;
int recorde;
int numInimigos = (5+pontos);
void draw() {
  background(fundo);

  fill(0);
  textSize(25);
  textAlign(CENTER, BOTTOM);
  text(+pontos, 81, 73);
  textSize(20);
  textAlign(CENTER, BOTTOM);
  text(+recorde, 195, 69);
   
  if (pontos==0) {
     
      }
  if (listaInimigos.size()<=numInimigos) {
    listaInimigos.add(new Inimigo());
    listaInimigos.add(new Livro());  
    listaInimigos.add(new Prova());
  }


  for (Inimigo i : listaInimigos) {
    i.mover();
    i.desenha();
    meuCalouro.desenha();
    
    if (i.verificaColisao(meuCalouro)) {
      meuCalouro.X = 50;
      meuCalouro.Y = 245;
      for (Inimigo i2 : listaInimigos) {
        i2.reset();
      }
      
    }
  }
  
  
}

void keyPressed() {
  if (keyCode == UP) {
    meuCalouro.mover(0, -5);
  }
  if (keyCode == DOWN) {
    meuCalouro.mover(0, 5);
  }
  if (keyCode == LEFT) {
    meuCalouro.mover(-5, 0);
  }
  if (keyCode == RIGHT) {
    meuCalouro.mover(5, 0);
  }
}

class Livro extends Inimigo {
  Livro() {
    velocidade = 1;
    imagem = loadImage("Livro.png");
   
  }
}

class Prova extends Inimigo {
  Prova() {
    velocidade = 1; 
    imagem = loadImage("Prova.png");

  }
}