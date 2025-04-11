package alternativa.tanks.models.battle.gui.gui.statistics.messages {
  import alternativa.tanks.models.battle.battlefield.common.MessageContainer;
  import alternativa.tanks.models.battle.battlefield.common.MessageLine;
  import alternativa.tanks.models.battle.battlefield.event.ChatOutputLineEvent;

  public class BattleMessagesOutput extends MessageContainer {
    public var maxMessages:int = 10;

    public function BattleMessagesOutput() {
      super();
      messageSpacing = 6;
    }

    public function addLine(param1:MessageLine) : void {
      var local3:MessageLine = null;
      pushBack(param1);
      if(container.numChildren > this.maxMessages) {
        local3 = removeFirstMessage();
        if(local3 != null) {
          local3.removeEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
          local3.removeEventListener(ChatOutputLineEvent.UPDATE_UID,this.updateUid);
        }
      }
      param1.addEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
      param1.addEventListener(ChatOutputLineEvent.UPDATE_UID,this.updateUid);
      var local2:int = param1 is KillMessageOutputLine ? 6 : 10;
      param1.x = -param1.width - local2;
    }

    private function killLine(param1:ChatOutputLineEvent) : void {
      if(container.contains(param1.line)) {
        removeFirstMessage();
      }
      param1.line.removeEventListener(ChatOutputLineEvent.KILL_ME,this.killLine);
    }

    private function updateUid(param1:ChatOutputLineEvent) : void {
      var local2:MessageLine = param1.line;
      var local3:int = local2 is KillMessageOutputLine ? 6 : 10;
      local2.x = -local2.width - local3;
      local2.removeEventListener(ChatOutputLineEvent.UPDATE_UID,this.killLine);
    }
  }
}
