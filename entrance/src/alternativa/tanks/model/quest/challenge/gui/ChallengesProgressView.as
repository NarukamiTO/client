package alternativa.tanks.model.quest.challenge.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import base.DiscreteSprite;
  import controls.Label;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.geom.Point;
  import forms.ColorConstants;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ChallengesProgressView extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static const progressBarBgClass:Class = ChallengesProgressView_progressBarBgClass;
    private static const progressBarBgBitmapData:BitmapData = new progressBarBgClass().bitmapData;
    private static const progressBarFillBgClass:Class = ChallengesProgressView_progressBarFillBgClass;
    private static const progressBarFillBgBitmapData:BitmapData = new progressBarFillBgClass().bitmapData;
    private static const starClass:Class = ChallengesProgressView_starClass;
    private static const starBitmapData:BitmapData = new starClass().bitmapData;

    private var point:Point = new Point();
    private var fillBitmap:Bitmap = new Bitmap();
    private var label:* = new Label();

    public function ChallengesProgressView() {
      super();
      addChild(new Bitmap(progressBarBgBitmapData));
      addChild(this.fillBitmap);
      var local1:Bitmap = new Bitmap(starBitmapData);
      local1.x = 5;
      local1.y = 6;
      addChild(local1);
      this.label.bold = true;
      this.label.color = ColorConstants.GREEN_LABEL;
      this.label.x = local1.x + local1.width + 5;
      this.label.y = 3;
      addChild(this.label);
    }

    public function setProgress(param1:int, param2:int, param3:int) : void {
      this.label.text = localeService.getText(TanksLocale.TEXT_CHALLENGE_STARS) + " " + param2 + "/" + param3;
      if(param1 == 0) {
        this.fillBitmap.bitmapData = null;
        return;
      }
      if(param1 == 100) {
        this.fillBitmap.bitmapData = progressBarFillBgBitmapData;
        return;
      }
      var local4:Number = progressBarBgBitmapData.width * param1 / 100;
      var local5:BitmapData = new BitmapData(local4,progressBarBgBitmapData.height);
      local5.copyPixels(progressBarFillBgBitmapData,local5.rect,this.point);
      this.fillBitmap.bitmapData = local5;
    }
  }
}
