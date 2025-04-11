package alternativa.tanks.models.battle.gui.chat {
  import alternativa.tanks.models.battle.battlefield.common.MessageContainer;
  import alternativa.tanks.models.battle.battlefield.common.MessageLine;
  import alternativa.tanks.models.battle.battlefield.event.ChatOutputLineEvent;
  import alternativa.types.Long;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import forms.userlabel.ChatUpdateEvent;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  public class BattleChatOutput extends MessageContainer {
    private static const LINE_WIDTH:int = 300;
    private static const MAX_MESSAGES:int = 100;
    private static const MIN_MESSAGES:int = 5;

    private var buffer:Array = [];
    private var minimizedMode:Boolean = true;
    private var updateId:uint = 0;

    public function BattleChatOutput() {
      super();
    }

    public function addLine(param1:Long, param2:BattleTeam, param3:String, param4:Boolean, param5:Boolean) : void {
      this.removeFirsLineIfNeeded();
      var local6:BattleChatLine = new BattleChatLine(param1,param2,param3,param4,param5);
      local6.addEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
      this.addToBuffer(local6);
      pushBack(local6);
      container.addEventListener(ChatUpdateEvent.UPDATE,this.onUpdateEvent);
    }

    private function onUpdateEvent(param1:ChatUpdateEvent) : void {
      if(this.updateId != 0) {
        clearTimeout(this.updateId);
      }
      this.updateId = setTimeout(this.updateLines,100);
    }

    private function updateLines() : void {
      var local1:MessageLine = null;
      this.updateId = 0;
      for each(local1 in this.buffer) {
        if(local1 is BattleChatLine) {
          BattleChatLine(local1).alignChatUserLabel();
        }
      }
    }

    public function addSystemMessage(param1:String) : void {
      this.removeFirsLineIfNeeded();
      var local2:BattleChatSystemLine = new BattleChatSystemLine(LINE_WIDTH,param1);
      local2.addEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
      this.addToBuffer(local2);
      pushBack(local2);
    }

    override public function removeFirstMessage(param1:Boolean = false) : MessageLine {
      var local2:MessageLine = super.removeFirstMessage();
      this.y += shift;
      if(param1) {
        this.buffer.shift();
      }
      return local2;
    }

    public function maximize() : void {
      var local1:int = 0;
      var local3:MessageLine = null;
      this.minimizedMode = false;
      var local2:int = this.buffer.length - container.numChildren;
      local1 = 0;
      while(local1 < container.numChildren) {
        local3 = MessageLine(container.getChildAt(local1));
        local3.killStop();
        local1++;
      }
      local1 = local2 - 1;
      while(local1 >= 0) {
        try {
          pushFront(MessageLine(this.buffer[local1]));
        }
        catch(err:Error) {
        }
        local1--;
      }
    }

    public function minimize() : void {
      var local1:int = 0;
      var local3:MessageLine = null;
      this.minimizedMode = true;
      var local2:int = container.numChildren - MIN_MESSAGES;
      local1 = 0;
      while(local1 < local2) {
        this.removeFirstMessage();
        local1++;
      }
      local1 = 0;
      while(local1 < container.numChildren) {
        local3 = MessageLine(container.getChildAt(local1));
        if(!local3.alive) {
          this.removeFirstMessage();
          local1--;
        } else {
          local3.killStart();
        }
        local1++;
      }
    }

    public function clear() : void {
      this.buffer.length = 0;
      var local1:int = container.numChildren - 1;
      while(local1 >= 0) {
        container.removeChildAt(local1);
        local1--;
      }
    }

    private function killLine(param1:ChatOutputLineEvent) : void {
      if(this.minimizedMode && container.contains(param1.line)) {
        this.removeFirstMessage();
      }
      param1.line.removeEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
    }

    private function removeFirsLineIfNeeded() : void {
      if(this.minimizedMode && container.numChildren > MIN_MESSAGES || !this.minimizedMode && container.numChildren >= MAX_MESSAGES) {
        this.removeFirstMessage();
      }
    }

    private function addToBuffer(param1:MessageLine) : void {
      this.buffer.push(param1);
      if(this.buffer.length > MAX_MESSAGES) {
        this.buffer.shift();
      }
    }
  }
}
