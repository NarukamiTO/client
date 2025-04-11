package projects.tanks.clients.fp10.Prelauncher.controls.buttons {
  import flash.events.Event;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.makeup.MakeUp;

  public class ExitButton extends Button {
    public function ExitButton(onClick:Function) {
      super(onClick);
      addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
    }

    private function addedToStage(e:Event) : void {
      addChildToCenter(MakeUp.getExitButtonMakeUp());
      addChildToCenter(MakeUp.getActiveExitButtonMakeUp());
      addChild(textField);
      getChildAt(1).visible = false;
    }

    override public function switchLocale(locale:Locale) : void {
      textField.defaultTextFormat.font = MakeUp.getFont(locale);
      textField.text = locale.exitText;
      textField.width += 5;
      textFieldToCenter();
      textField.textColor = 16751998;
    }

    override protected function onResize(e:Event) : void {
      this.x = stage.stageWidth >> 1;
      this.y = (stage.stageHeight >> 1) + 150;
    }
  }
}
