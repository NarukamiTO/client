package projects.tanks.clients.fp10.Prelauncher.controls.logo {
  import flash.events.Event;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.LocalizedControl;
  import projects.tanks.clients.fp10.Prelauncher.makeup.MakeUp;

  public class Logo extends LocalizedControl {
    public function Logo() {
      super();
    }

    override public function switchLocale(locale:Locale) : void {
      removeChildren();
      addChildToCenter(MakeUp.getLogoMakeUp(locale));
    }

    override protected function onResize(e:Event) : void {
      this.x = stage.stageWidth >> 1;
      this.y = stage.stageHeight / 3;
    }
  }
}
