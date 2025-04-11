package alternativa.tanks.view {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.view.forms.primivites.Alert;
  import controls.DefaultButton;
  import controls.TankWindow;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.ui.Keyboard;
  import org.robotlegs.core.IInjector;
  import projects.tanks.clients.flash.commons.models.captcha.CaptchaSection;
  import projects.tanks.clients.flash.commons.models.captcha.RefreshCaptchaClickedEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class StandAloneCaptchaForm extends Sprite {
    [Inject]
    public var localeService:ILocaleService;

    [Inject]
    public var injector:IInjector;

    private var captchaSection:CaptchaSection;

    public var playButton:DefaultButton;

    private var _border:int = 25;
    private var _margin:int = 20;

    public function StandAloneCaptchaForm() {
      super();
    }

    [PostConstruct]
    public function postConstruct() : void {
      var bg:TankWindow = new TankWindow(325,200);
      addChild(bg);
      this.captchaSection = this.injector.instantiate(CaptchaSection);
      this.captchaSection.x = this._border;
      this.captchaSection.y = this._border;
      addChild(this.captchaSection);
      this.playButton = new DefaultButton();
      this.playButton.label = this.localeService.getText(TanksLocale.TEXT_CAPTCHA_PROCEED_BUTTON);
      this.playButton.y = this.captchaSection.y + this.captchaSection.height + this._margin;
      this.playButton.x = bg.width - this._border - this.playButton.width;
      bg.height = this._border + this.playButton.y + this.playButton.height;
      addChild(this.playButton);
      this.captchaSection.refreshButton.addEventListener(MouseEvent.CLICK,function():void {
        dispatchEvent(new RefreshCaptchaClickedEvent());
      });
      addEventListener(Event.ADDED_TO_STAGE,function(param1:Event):void {
        var e:Event = param1;
        captchaSection.captchaAnswer.addEventListener(KeyboardEvent.KEY_DOWN,onPlayClickedKey);
        stage.focus = captchaSection.captchaAnswer.textField;
        addEventListener(Event.REMOVED_FROM_STAGE,function():void {
          stage.removeEventListener(Event.RESIZE,onResize);
          captchaSection.captchaAnswer.removeEventListener(KeyboardEvent.KEY_DOWN,onPlayClickedKey);
        });
        stage.addEventListener(Event.RESIZE,onResize);
        onResize();
      });
    }

    private function onResize(param1:Event = null) : void {
      this.x = int((stage.stageWidth - this.width) / 2);
      this.y = int((stage.stageHeight - this.height) / 2);
    }

    private function onPlayClickedKey(param1:KeyboardEvent) : void {
      if(param1.keyCode == Keyboard.ENTER) {
        this.playButton.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
    }

    public function get captchaAnswer() : String {
      return this.captchaSection.captchaAnswer.value;
    }

    public function showCaptcha(param1:Bitmap) : void {
      this.captchaSection.captcha = param1;
    }

    public function captchaFailed() : void {
      this.showErrorWindow(Alert.CAPTCHA_INCORRECT);
      this.captchaSection.captchaAnswer.clear();
    }

    private function showErrorWindow(param1:int) : void {
      var local2:Alert = new Alert(param1);
      parent.addChild(local2);
      stage.focus = local2.closeButton;
    }

    public function set captchaAnswer(param1:String) : void {
      this.captchaSection.captchaAnswer.textField.text = param1;
    }
  }
}
