package alternativa.tanks.models.battle.gui.gui.statistics.messages {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.models.battle.gui.statistics.ShortUserInfo;
  import flash.display.Sprite;
  import flash.events.Event;
  import projects.tanks.client.battlefield.types.DamageType;

  public class BattleMessages extends Sprite {
    [Inject]
    public static var display:IDisplay;

    private var output:BattleMessagesOutput = new BattleMessagesOutput();

    public function BattleMessages() {
      super();
      addChild(this.output);
      this.output.tabEnabled = false;
      this.output.tabChildren = false;
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
    }

    private function onAddedToStage(param1:Event) : void {
      stage.addEventListener(Event.RESIZE,this.onStageResize);
    }

    private function onRemovedFromStage(param1:Event) : void {
      stage.removeEventListener(Event.RESIZE,this.onStageResize);
    }

    public function onStageResize(param1:Event) : void {
      this.alignMessages();
    }

    private function alignMessages() : void {
      this.output.x = display.stage.stageWidth;
      this.output.y = 50;
    }

    public function addTwoUsersActionMessage(param1:ShortUserInfo, param2:UserAction, param3:ShortUserInfo) : void {
      this.output.addLine(ActionOutputLine.userAction(param1,param2,param3));
      this.alignMessages();
    }

    public function addUserActionMessage(param1:ShortUserInfo, param2:UserAction) : void {
      this.output.addLine(ActionOutputLine.userAction(param1,param2,null));
      this.alignMessages();
    }

    public function addSimpleActionMessage(param1:UserAction) : void {
      this.output.addLine(ActionOutputLine.simple(param1));
      this.alignMessages();
    }

    public function addUserTextActionMessage(param1:ShortUserInfo, param2:String) : void {
      this.output.addLine(new OldActionOutputLine(param1,param2));
      this.alignMessages();
    }

    public function addPointActionMessage(param1:String, param2:UserAction) : void {
      this.output.addLine(ActionOutputLine.pointAction(param1,param2));
      this.alignMessages();
    }

    public function addKillMessage(param1:ShortUserInfo, param2:ShortUserInfo, param3:DamageType) : void {
      this.output.addLine(new KillMessageOutputLine(param1,param2,param3));
      this.alignMessages();
    }
  }
}
