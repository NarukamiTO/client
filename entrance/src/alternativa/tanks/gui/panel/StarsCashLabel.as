package alternativa.tanks.gui.panel {
  import alternativa.tanks.model.quest.challenge.stars.StarsChangedEvent;
  import alternativa.tanks.model.quest.challenge.stars.StarsInfoService;
  import controls.buttons.FixedHeightButton;
  import controls.buttons.h30px.GrayFrameMediumLabelSkin;
  import controls.buttons.h30px.H30ButtonSkin;
  import flash.display.Bitmap;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;

  public class StarsCashLabel extends FixedHeightButton {
    [Inject]
    public static var starsInfoService:StarsInfoService;

    private static const X_OFFSET_ICON:* = 6;

    private var icon:Bitmap;

    public function StarsCashLabel() {
      super(new GrayFrameMediumLabelSkin());
      labelSize = H30ButtonSkin.DEFAULT_LABEL_SIZE;
      labelHeight = H30ButtonSkin.DEFAULT_LABEL_HEIGHT;
      labelPositionY = H30ButtonSkin.DEFAULT_LABEL_Y - 2;
      width = 86;
      enabled = true;
      _label.color = ColorConstants.GREEN_LABEL;
      _label.align = TextFormatAlign.RIGHT;
      this.icon = new StarsIcon.icon_class();
      _innerLayer.addChild(this.icon);
      this.icon.x = width - this.icon.width - X_OFFSET_ICON;
      this.icon.y = int((height - this.icon.height) * 0.5) - 2;
      _label.width = width - this.icon.width - X_OFFSET_ICON - 4;
      this.updateStars(null);
      starsInfoService.addEventListener(StarsChangedEvent.STARS_CHANGED,this.updateStars);
    }

    private function updateStars(param1:StarsChangedEvent) : * {
      _label.text = starsInfoService.getStars().toString();
    }

    public function destroy() : void {
      starsInfoService.removeEventListener(StarsChangedEvent.STARS_CHANGED,this.updateStars);
    }
  }
}
