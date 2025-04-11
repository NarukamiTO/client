package projects.tanks.clients.fp10.TanksLauncherErrorScreen {
  import controls.TankWindowInner;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.text.TextFormatAlign;

  public class TankErrorWindow extends Sprite {
    private static const bitmapTechnical:Class = TankErrorWindow_bitmapTechnical;

    private var window:TankWindow;
    private var inner:TankWindowInner;
    private var messageLabel:LabelBase;
    private var windowWidth:int = 450;
    private var windowHeight:int = 300;

    private const windowMargin:int = 12;
    private const margin:int = 9;

    private var technicalBitmap:Bitmap;

    public function TankErrorWindow() {
      super();
      this.technicalBitmap = new Bitmap(new bitmapTechnical().bitmapData);
    }

    public function init(messageText:String, locale:String) : void {
      this.window = new TankWindow(this.windowWidth,this.windowHeight);
      addChild(this.window);
      this.inner = new TankWindowInner(this.windowWidth - this.windowMargin * 2,this.windowHeight - this.windowMargin * 2,TankWindowInner.GREEN);
      this.inner.x = this.inner.y = this.windowMargin;
      addChild(this.inner);
      this.technicalBitmap.x = this.windowWidth - this.technicalBitmap.width >> 1;
      this.technicalBitmap.y = this.windowMargin * 2;
      addChild(this.technicalBitmap);
      this.messageLabel = new LabelBase();
      this.messageLabel.align = TextFormatAlign.CENTER;
      this.messageLabel.wordWrap = true;
      this.messageLabel.multiline = true;
      this.messageLabel.embedFonts = TankFont.needEmbedFont(locale);
      this.messageLabel.htmlText = messageText;
      this.messageLabel.x = this.windowMargin * 2;
      this.messageLabel.y = this.technicalBitmap.y + this.technicalBitmap.height + this.margin;
      this.messageLabel.width = this.windowWidth - this.windowMargin * 4;
      addChild(this.messageLabel);
      if(this.messageLabel.numLines > 2) {
        this.messageLabel.align = TextFormatAlign.CENTER;
        this.messageLabel.htmlText = messageText;
        this.messageLabel.width = this.windowWidth - this.windowMargin * 4;
      }
      var local3:int = 13;
      this.messageLabel.setTextFormat(TankFont.getLocaleTextFormat(locale,local3));
      this.window.height = this.messageLabel.y + this.messageLabel.height + this.windowMargin * 2;
      this.inner.height = this.window.height - 2 * this.windowMargin;
    }
  }
}
