package alternativa.tanks.models.statistics {
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.tanks.models.battlemessages.BattlefieldMessages;
  import flash.events.Event;
  import platform.client.fp10.core.type.AutoClosable;

  public class BattlefieldMessagesAligner implements AutoClosable {
    [Inject]
    public static var display:IDisplay;

    private var battlefieldMessages:BattlefieldMessages;

    public function BattlefieldMessagesAligner(param1:BattlefieldMessages) {
      super();
      this.battlefieldMessages = param1;
      display.stage.addEventListener(Event.RESIZE,this.onStageResize);
      this.align();
    }

    private function onStageResize(param1:Event) : void {
      this.align();
    }

    private function align() : void {
      var local1:int = int(display.stage.stageWidth);
      this.battlefieldMessages.x = 0.5 * local1;
      this.battlefieldMessages.y = 40;
    }

    [Obfuscation(rename="false")]
    public function close() : void {
      this.battlefieldMessages = null;
      display.stage.removeEventListener(Event.RESIZE,this.onStageResize);
    }
  }
}
