package alternativa.tanks.models.battlemessages {
  import controls.Label;
  import flash.display.Sprite;
  import flash.filters.GlowFilter;

  public class BattlefieldMessages extends Sprite {
    private const MAX_MESSAGES:int = 3;
    private const VERTICAL_INTERVAL:int = 18;

    private var numMessages:int;
    private var messages:Vector.<Message> = new Vector.<Message>();
    private var numPooledMessages:int;
    private var messagePool:Vector.<Message> = new Vector.<Message>();

    public function BattlefieldMessages() {
      super();
      filters = [new GlowFilter(0,0.75,5,5)];
    }

    public function addMessage(param1:uint, param2:String) : void {
      this.removeFirstMessageIfFull();
      var local3:Message = this.messages[this.numMessages] = this.createMessage();
      local3.init();
      this.addLabel(local3,param1,param2);
    }

    public function addMessageWithDuration(param1:uint, param2:String, param3:int) : void {
      this.removeFirstMessageIfFull();
      var local4:Message = this.messages[this.numMessages] = this.createMessage();
      local4.initWithDuration(param3);
      this.addLabel(local4,param1,param2);
    }

    private function removeFirstMessageIfFull() : void {
      if(this.numMessages == this.MAX_MESSAGES) {
        this.removeMessage(0);
      }
    }

    private function addLabel(param1:Message, param2:uint, param3:String) : void {
      var local4:Label = param1.getLabel();
      addChild(local4);
      local4.color = param2;
      local4.text = param3;
      local4.x = -0.5 * local4.width;
      local4.y = this.VERTICAL_INTERVAL * this.numMessages;
      ++this.numMessages;
    }

    public function update(param1:uint) : void {
      var local3:Message = null;
      var local2:int = 0;
      while(local2 < this.numMessages) {
        local3 = this.messages[local2];
        if(local3.isDead) {
          this.removeMessage(local2);
          local2--;
        } else {
          local3.update(param1);
        }
        local2++;
      }
    }

    public function removeFromParent() : void {
      if(parent != null) {
        parent.removeChild(this);
      }
    }

    private function removeMessage(param1:int) : void {
      var local4:Label = null;
      var local2:Message = this.messages[param1];
      this.destroyMessage(local2);
      var local3:int = param1 + 1;
      while(local3 < this.numMessages) {
        local2 = this.messages[int(local3 - 1)] = this.messages[local3];
        local4 = local2.getLabel();
        local4.y -= this.VERTICAL_INTERVAL;
        local3++;
      }
      --this.numMessages;
    }

    private function destroyMessage(param1:Message) : void {
      removeChild(param1.getLabel());
      var local2:* = this.numPooledMessages++;
      this.messagePool[local2] = param1;
    }

    private function createMessage() : Message {
      var local1:Message = null;
      if(this.numPooledMessages == 0) {
        local1 = new Message();
      } else {
        local1 = this.messagePool[--this.numPooledMessages];
        this.messagePool[this.numPooledMessages] = null;
      }
      return local1;
    }
  }
}
