package alternativa.tanks.models.battle.gui.gui.statistics.messages {
  import alternativa.tanks.models.battle.battlefield.common.MessageLine;
  import alternativa.tanks.models.battle.battlefield.event.ChatOutputLineEvent;
  import alternativa.tanks.models.battle.ctf.MessageColor;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import alternativa.tanks.models.battle.gui.userlabel.BattleActionUserLabel;
  import alternativa.tanks.models.battle.gui.userlabel.BattleChatUserLabel;
  import controls.Label;
  import forms.userlabel.ChatUpdateEvent;

  public class OldActionOutputLine extends MessageLine {
    private var userLabel:BattleChatUserLabel;
    private var label:Label;

    public function OldActionOutputLine(param1:ShortUserInfo, param2:String, param3:ShortUserInfo = null) {
      super();
      if(param1 != null) {
        this.createUserLabel(param1);
      }
      this.createActionTextLabel(param2);
      if(param3 != null) {
        this.createUserLabel(param3);
      }
    }

    private function createUserLabel(param1:ShortUserInfo) : void {
      this.userLabel = new BattleActionUserLabel(param1.userId);
      this.userLabel.addEventListener(ChatUpdateEvent.UPDATE,this.onUpdateEvent);
      this.userLabel.setUidColor(MessageColor.getUserNameColor(param1.teamType,false),true);
      this.userLabel.x = width + 4;
      addChild(this.userLabel);
    }

    private function onUpdateEvent(param1:ChatUpdateEvent) : void {
      this.userLabel.x = 4;
      this.label.x = this.userLabel.width + 4;
      dispatchEvent(new ChatOutputLineEvent(ChatOutputLineEvent.UPDATE_UID,this));
    }

    private function createActionTextLabel(param1:String) : void {
      this.label = new Label();
      this.label.text = param1;
      this.label.x = width + 4;
      shadowContainer.addChild(this.label);
    }
  }
}
