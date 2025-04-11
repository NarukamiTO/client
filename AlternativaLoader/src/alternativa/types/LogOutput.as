package alternativa.types {
  import flash.events.Event;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class LogOutput extends TextField {
    public function LogOutput() {
      super();
      defaultTextFormat = new TextFormat("Tahoma",11,16777215);
      multiline = true;
      wordWrap = true;
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
    }

    public function addLine(param1:String) : void {
      appendText(param1 + "\n");
    }

    private function onAddedToStage(param1:Event) : void {
      stage.addEventListener(Event.RESIZE,this.onStageResize);
      this.onStageResize(null);
    }

    private function onRemovedFromStage(param1:Event) : void {
      stage.removeEventListener(Event.RESIZE,this.onStageResize);
    }

    private function onStageResize(param1:Event) : void {
      width = stage.stageWidth;
      height = stage.stageHeight;
    }
  }
}
