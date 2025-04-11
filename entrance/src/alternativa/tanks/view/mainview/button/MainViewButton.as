package alternativa.tanks.view.mainview.button {
  import alternativa.tanks.gui.frames.FrameBase;
  import alternativa.tanks.gui.frames.GreenFrame;
  import base.DiscreteSprite;
  import controls.BigButton;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import forms.ColorConstants;

  public class MainViewButton extends DiscreteSprite {
    protected static const PADDING:int = 14;
    protected static const IMAGE_SIZE:int = 80;
    protected static const FRAME_HEIGHT:int = IMAGE_SIZE + 2 * PADDING;

    protected var image:Bitmap;
    protected var nameLabel:LabelBase = new LabelBase();
    protected var descriptionLabel:LabelBase = new LabelBase();
    protected var frame:FrameBase;
    protected var button:LockedByRankButton;

    private var spectatorButton:BigButton;

    public function MainViewButton(param1:String, param2:String, param3:Bitmap, param4:int, param5:FrameBase = null) {
      super();
      this.frame = param5 != null ? param5 : new GreenFrame(100,FRAME_HEIGHT);
      this.frame.x = PADDING;
      this.frame.y = PADDING;
      addChild(this.frame);
      this.image = param3;
      var local6:Sprite = new Sprite();
      local6.x = PADDING;
      local6.y = (this.frame.height - param3.height) / 2;
      local6.addChild(param3);
      this.frame.addChild(local6);
      this.nameLabel.color = ColorConstants.GREEN_LABEL;
      this.nameLabel.size = 18;
      this.nameLabel.text = param1;
      this.nameLabel.x = PADDING * 2 + this.image.width;
      this.nameLabel.y = 10;
      this.frame.addChild(this.nameLabel);
      this.descriptionLabel.autoSize = TextFieldAutoSize.NONE;
      this.descriptionLabel.color = ColorConstants.GREEN_LABEL;
      this.descriptionLabel.size = 14;
      this.descriptionLabel.text = param2;
      this.descriptionLabel.wordWrap = true;
      this.descriptionLabel.x = this.nameLabel.x;
      this.descriptionLabel.y = 40;
      this.frame.addChild(this.descriptionLabel);
      this.button = new LockedByRankButton(param4);
      this.button.y = FRAME_HEIGHT - this.button.height >> 1;
      this.button.x = this.frame.width - this.button.width - this.button.y;
      this.frame.addChild(this.button);
      this.button.addEventListener(MouseEvent.CLICK,this.onClick);
      this.spectatorButton = new BigButton();
      this.spectatorButton.label = "Spectator";
      this.spectatorButton.y = FRAME_HEIGHT - this.spectatorButton.height >> 1;
      this.spectatorButton.x = this.frame.width - this.spectatorButton.width - this.spectatorButton.y - this.button.width - 10;
      this.frame.addChild(this.spectatorButton);
      this.spectatorButton.addEventListener(MouseEvent.CLICK,this.onSpectatorClick);
      this.spectatorButton.visible = false;
      graphics.drawRect(0,0,0,this.frame.height);
    }

    protected function onClick(param1:MouseEvent) : void {
    }

    protected function onSpectatorClick(param1:MouseEvent) : void {
    }

    public function resize(param1:int) : void {
      var local2:int = param1 - 2 * PADDING - 8;
      this.frame.setWidth(local2);
      this.descriptionLabel.width = local2 - this.nameLabel.x - this.button.width - 3 * PADDING;
      this.descriptionLabel.height = 70;
      this.button.x = local2 - this.button.width - this.button.y;
      this.spectatorButton.x = local2 - this.spectatorButton.width - this.spectatorButton.y - this.button.width - 10;
    }

    public function lockButton() : void {
      this.button.enabled = false;
    }

    public function unlockIfPossible() : void {
      this.button.unlockIfPossible();
    }

    public function setSpectatorsButtonVisible(param1:Boolean) : void {
      this.spectatorButton.visible = param1;
    }
  }
}
