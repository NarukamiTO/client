package alternativa.tanks.models.battle.battlefield.common {
  import flash.display.Sprite;

  public class MessageContainer extends Sprite {
    protected var messageSpacing:int = 3;
    protected var container:Sprite = new Sprite();
    protected var shift:Number;

    public function MessageContainer() {
      super();
      addChild(this.container);
    }

    public function removeFirstMessage(param1:Boolean = false) : MessageLine {
      var local2:int = this.container.numChildren;
      if(local2 == 0) {
        return null;
      }
      var local3:MessageLine = MessageLine(this.container.getChildAt(0));
      this.shift = int(local3.height + local3.y + this.messageSpacing);
      this.container.removeChild(local3);
      local2--;
      var local4:int = 0;
      while(local4 < local2) {
        this.container.getChildAt(local4).y = this.container.getChildAt(local4).y - this.shift;
        local4++;
      }
      return local3;
    }

    protected function pushFront(param1:MessageLine) : void {
      param1.y = 0;
      param1.alpha = 1;
      this.container.addChildAt(param1,0);
      var local2:int = this.container.numChildren;
      var local3:int = 1;
      while(local3 < local2) {
        this.container.getChildAt(local3).y = this.container.getChildAt(local3).y + int(param1.height + this.messageSpacing);
        local3++;
      }
    }

    protected function pushBack(param1:MessageLine) : void {
      param1.y = this.container.numChildren > 0 ? int(this.container.height + this.messageSpacing) : 0;
      this.container.addChild(param1);
    }
  }
}
