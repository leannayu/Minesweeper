import de.bezier.guido.*;
public final static int NUM_ROWS=20,NUM_COLS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs= new ArrayList<MSButton>();
public boolean gameOver = false;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons=new MSButton[NUM_ROWS][NUM_COLS];
    for(int row=0;row<NUM_ROWS;row++){
        for(int col=0;col<NUM_COLS;col++){
            buttons[row][col] = new MSButton(row,col);
        }
    }   
    setBombs();
}
public void setBombs() 
{
    for (int i=1; i<=40; i++)
    {
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[row][col]))
        bombs.add(buttons[row][col]);
    }
}

public void keyPressed(){
    gameOver = false;
    for(int rr = 0; rr < NUM_ROWS; rr++){
        for(int cc = 0; cc < NUM_COLS; cc++){
            bombs.remove(buttons[rr][cc]);
            buttons[rr][cc].clicked = false;
            buttons[rr][cc].marked = false;
            buttons[rr][cc].setLabel("");
        }
    }
    setBombs();
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for (int i =0; i< bombs.size (); i++) {
    if (bombs.get(i).isMarked() == false)
      return false;
  }
  return true;
}
public void displayLosingMessage()
{
  gameOver = true;
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O");
  buttons[9][8].setLabel("U");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("L");
  buttons[9][11].setLabel("O");
  buttons[9][12].setLabel("S");
  buttons[9][13].setLabel("E");
  for (int i =0; i < bombs.size (); i++) {
    bombs.get(i).marked = false;
    bombs.get(i).clicked = true;
  }
}
public void displayWinningMessage()
{
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O");
  buttons[9][8].setLabel("U");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("W");
  buttons[9][11].setLabel("I");
  buttons[9][12].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if (mouseButton == RIGHT)
            marked = !marked;
        else if (bombs.contains(this))
            displayLosingMessage();
        else if ( countBombs(r, c) > 0) 
        {
            fill(255); 
            setLabel(str(countBombs(r, c)));
        } else {
        if (isValid(r, c-1) && buttons[r][c-1].isClicked() == false)
            buttons[r][c-1].mousePressed();
        if (isValid(r, c+1) && buttons[r][c+1].isClicked() == false) 
            buttons[r][c+1].mousePressed();
        if (isValid(r-1, c-1) && buttons[r-1][c-1].isClicked() == false)
            buttons[r-1][c-1].mousePressed();
        if (isValid(r-1, c) && buttons[r-1][c].isClicked() == false)
            buttons[r-1][c].mousePressed();
        if (isValid(r-1, c+1) && buttons[r-1][c+1].isClicked() == false)
            buttons[r-1][c+1].mousePressed();
        if (isValid(r+1, c) && buttons[r+1][c].isClicked() == false)
            buttons[r+1][c].mousePressed();
        if (isValid(r+1, c+1) && buttons[r+1][c+1].isClicked() == false)
            buttons[r+1][c+1].mousePressed();
        if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked() == false)
        buttons[r+1][c-1].mousePressed();
    }
  }

  public void draw () 
  { 
    stroke(255);   
    if (marked) {
      fill(0);
    } else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill(200);
    else 
      fill(100);

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
    }

    public boolean isValid(int r, int c)
    {
        if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row+1,col) && bombs.contains(buttons[row+1][col]))
            numBombs++;
        if(isValid(row-1,col) && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if(isValid(row,col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if(isValid(row,col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if(isValid(row+1,col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if(isValid(row-1,col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        if(isValid(row+1,col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if(isValid(row-1,col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        return numBombs;
    }



