package alternativa.tanks.model.quest.challenge.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.Label;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import forms.ColorConstants;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class TierNumberView extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static const tierClass:Class = TierNumberView_tierClass;
    private static const tierBitmapData:BitmapData = new tierClass().bitmapData;

    private var backgroundBitmap:Bitmap = new Bitmap(tierBitmapData);
    private var levelLabel:Label = new Label();
    private var titleLabel:Label = new Label();

    public function TierNumberView() {
      super();
      addChild(this.backgroundBitmap);
      this.initLevelLabel();
      this.initTitleLabel();
    }

    public function set level(param1:int) : * {
      this.levelLabel.text = param1.toString();
      this.updateLabelPosition();
    }

    private function initLevelLabel() : void {
      this.levelLabel.size = 42;
      this.levelLabel.bold = true;
      this.levelLabel.color = ColorConstants.GREEN_LABEL;
      addChild(this.levelLabel);
    }

    private function initTitleLabel() : void {
      this.titleLabel.size = 15;
      this.titleLabel.text = localeService.getText(TanksLocale.TEXT_CHALLENGE_TIER);
      this.titleLabel.x = (this.backgroundBitmap.width - this.titleLabel.width) / 2;
      this.titleLabel.y = this.backgroundBitmap.height - 30;
      this.titleLabel.color = ColorConstants.GREEN_LABEL;
      addChild(this.titleLabel);
    }

    private function updateLabelPosition() : * {
      this.levelLabel.x = (this.backgroundBitmap.width - this.levelLabel.width) / 2;
      this.levelLabel.y = this.titleLabel.y - 40;
    }
  }
}
