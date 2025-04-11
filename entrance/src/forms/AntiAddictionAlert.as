package forms {
  import controls.base.LabelBase;
  import controls.statassets.BlackRoundRect;
  import flash.text.TextFormatAlign;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class AntiAddictionAlert extends DialogWindow {
    protected const PADDING:int = 15;

    protected var bg:BlackRoundRect = new BlackRoundRect();
    protected var timeLimitLabel:LabelBase = new LabelBase();

    public function AntiAddictionAlert(param1:String) {
      super();
      this.timeLimitLabel.align = TextFormatAlign.CENTER;
      this.timeLimitLabel.text = param1;
      addChild(this.bg);
      addChild(this.timeLimitLabel);
      this.timeLimitLabel.x = this.PADDING;
      this.timeLimitLabel.y = this.PADDING;
      this.bg.width = this.timeLimitLabel.width + this.PADDING * 2;
      this.bg.height = this.timeLimitLabel.height + this.PADDING * 2;
      dialogService.enqueueDialog(this);
    }

    public function removeFormDialog() : void {
      dialogService.removeDialog(this);
    }
  }
}
