package platform.client.fp10.core.service.errormessage.impl {
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.DropShadowFilter;
  import flash.geom.Point;
  import flash.text.AntiAliasType;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFieldType;
  import flash.text.TextFormat;
  import platform.client.fp10.core.service.errormessage.IMessageBox;
  import platform.client.fp10.core.service.errormessage.errors.ErrorType;

  public class DefaultMessageWindow extends Sprite implements IMessageBox {
    private var tfMessage:TextField;
    private var buttonOk:Button;
    private var _currentSize:Point;

    public function DefaultMessageWindow() {
      super();
      mouseEnabled = false;
      tabEnabled = false;
      this.createMessageField();
      this.createButton();
      this._currentSize = new Point(300,200);
      this.filters = [new DropShadowFilter(3,70,0,0.5,2,2,1,BitmapFilterQuality.MEDIUM,false,false,false)];
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    private function createButton() : void {
      this.buttonOk = new Button("Close");
      this.buttonOk.addEventListener(MouseEvent.CLICK,this.onOkButtonClick);
      addChild(this.buttonOk);
    }

    public function hide() : void {
      if(parent != null) {
        parent.removeChild(this);
      }
    }

    private function createMessageField() : void {
      this.tfMessage = new TextField();
      this.tfMessage.thickness = 50;
      this.tfMessage.sharpness = -50;
      this.tfMessage.width = 250;
      this.tfMessage.y = 25;
      this.tfMessage.defaultTextFormat = new TextFormat("Tahoma",11,0);
      this.tfMessage.type = TextFieldType.DYNAMIC;
      this.tfMessage.autoSize = TextFieldAutoSize.CENTER;
      this.tfMessage.antiAliasType = AntiAliasType.ADVANCED;
      this.tfMessage.embedFonts = false;
      this.tfMessage.selectable = true;
      this.tfMessage.multiline = true;
      this.tfMessage.wordWrap = true;
      addChild(this.tfMessage);
    }

    public function set text(param1:String) : void {
      this.tfMessage.text = param1;
      this._currentSize.x = Math.max(Math.round(this.tfMessage.length * 0.5),300);
      this.tfMessage.width = this._currentSize.x - 50;
      this.tfMessage.x = Math.round((this._currentSize.x - this.tfMessage.textWidth) * 0.5);
      this.repaint();
      this.align();
    }

    public function get currentSize() : Point {
      return this._currentSize;
    }

    private function repaint() : void {
      this._currentSize.y = 25 + this.tfMessage.textHeight + 30 + this.buttonOk.height;
      this.graphics.clear();
      this.graphics.beginFill(13421772,1);
      this.graphics.drawRoundRect(0,0,this._currentSize.x,this._currentSize.y,5,5);
      this.buttonOk.repaint();
      this.buttonOk.x = Math.round((this._currentSize.x - this.buttonOk.width) * 0.5);
      this.buttonOk.y = Math.round(this._currentSize.y - 15 - this.buttonOk.height);
    }

    private function onAddedToStage(param1:Event) : void {
      this.repaint();
      this.align();
    }

    private function align() : void {
      if(stage != null) {
        x = stage.stageWidth - width >> 1;
        y = stage.stageHeight - height >> 1;
      }
    }

    private function onOkButtonClick(param1:MouseEvent) : void {
      this.hide();
    }

    public function getDisplayObject(param1:ErrorType) : DisplayObject {
      this.text = param1.getMessage();
      return this;
    }
  }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
class Button extends Sprite {
  private static const H_MARGIN:int = 20;
  private static const V_MARGIN:int = 5;

  private var tfCaption:TextField;

  public function Button(param1:String) {
    super();
    this.createCaptionTextField();
    this.caption = param1;
  }

  public function set caption(param1:String) : void {
    this.tfCaption.text = param1;
    this.repaint();
  }

  public function repaint() : void {
    if(stage == null) {
      return;
    }
    var local1:int = this.tfCaption.textWidth + 2 * H_MARGIN;
    var local2:int = this.tfCaption.textHeight + 2 * V_MARGIN;
    this.tfCaption.x = local1 - this.tfCaption.textWidth >> 1;
    this.tfCaption.y = local2 - this.tfCaption.textHeight >> 1;
    graphics.beginFill(16777215,1);
    graphics.lineStyle(0,6710886);
    graphics.drawRoundRect(0,0,local1,local2,5,5);
  }

  private function createCaptionTextField() : void {
    this.tfCaption = new TextField();
    this.tfCaption.thickness = 50;
    this.tfCaption.sharpness = -50;
    this.tfCaption.defaultTextFormat = new TextFormat("Tahoma",12,0,true);
    this.tfCaption.type = TextFieldType.DYNAMIC;
    this.tfCaption.autoSize = TextFieldAutoSize.LEFT;
    this.tfCaption.antiAliasType = AntiAliasType.ADVANCED;
    this.tfCaption.embedFonts = false;
    this.tfCaption.selectable = false;
    this.tfCaption.multiline = false;
    this.tfCaption.mouseEnabled = false;
    this.tfCaption.tabEnabled = false;
    addChild(this.tfCaption);
  }
}
