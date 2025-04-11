package forms.payment {
  import controls.Money;
  import controls.statassets.StatLineBackgroundNormal;
  import controls.statassets.StatLineBackgroundSelected;
  import controls.statassets.StatLineNormal;
  import fl.controls.List;
  import fl.data.DataProvider;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.Event;
  import utils.ScrollStyleUtils;

  public class PaymentList extends Sprite {
    private static var _withSMSText:Boolean = false;

    private var list:List = new List();
    private var header:PaymentListHeader = new PaymentListHeader();
    private var dp:DataProvider = new DataProvider();
    private var _width:int = 100;
    private var _height:int = 100;

    public function PaymentList() {
      super();
      addEventListener(Event.ADDED_TO_STAGE,this.ConfigUI);
      ScrollStyleUtils.setGreenStyle(this.list);
    }

    private static function setBackground(param1:int) : BitmapData {
      var local2:Sprite = new Sprite();
      var local3:StatLineNormal = new StatLineNormal();
      var local4:StatLineNormal = new StatLineNormal();
      var local5:StatLineNormal = new StatLineNormal();
      var local6:StatLineNormal = new StatLineNormal();
      var local7:BitmapData = new BitmapData(param1 > 0 ? param1 : 1,23,true,0);
      var local8:int = _withSMSText ? 80 : int((param1 - 70) / 2);
      local3.height = local4.height = local5.height = local6.height = 21;
      local2.addChild(local3);
      local2.addChild(local5);
      local2.addChild(local6);
      local3.width = 70;
      local5.x = 72;
      if(_withSMSText) {
        local2.addChild(local4);
        local4.x = 72;
        local4.width = param1 - 210;
        local5.x = 74 + local4.width;
      }
      local5.width = local8;
      local6.x = local5.x + local5.width + 2;
      local6.width = int(param1 - local6.x - 3);
      local7.draw(local2);
      return local7;
    }

    public function set withSMSText(param1:Boolean) : void {
      _withSMSText = param1;
      this.header.withSMSText = param1;
      this.dp.invalidate();
    }

    public function addItem(param1:String, param2:String, param3:String, param4:int, param5:String = "") : void {
      var local6:Object = new Object();
      local6.number = param1;
      local6.cost = String(param2) + " " + param3;
      local6.crystals = Money.numToString(param4,false);
      local6.smsText = param5;
      this.dp.addItem(local6);
      this.header.width = this.list.verticalScrollBar.visible ? this._width - 15 : this._width;
      StatLineBackgroundNormal.bg = new Bitmap(setBackground(this.list.verticalScrollBar.visible ? this._width - 15 : this._width));
      StatLineBackgroundSelected.bg = new Bitmap(setBackground(this.list.verticalScrollBar.visible ? this._width - 15 : this._width));
      this.dp.invalidate();
    }

    public function clear() : void {
      this.dp.removeAll();
    }

    private function ConfigUI(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.ConfigUI);
      this.list.rowHeight = 22;
      this.list.setStyle("cellRenderer",PaymentListRenderer);
      this.list.focusEnabled = false;
      this.list.dataProvider = this.dp;
      ScrollStyleUtils.setGreenStyle(this.list);
      addChild(this.header);
      addChild(this.list);
      this.list.y = 20;
    }

    override public function set width(param1:Number) : void {
      this._width = int(param1);
      this.list.width = this._width;
      this.header.width = this.list.verticalScrollBar.visible ? this._width - 15 : this._width;
      StatLineBackgroundNormal.bg = new Bitmap(setBackground(this.list.verticalScrollBar.visible ? this._width - 15 : this._width));
      StatLineBackgroundSelected.bg = new Bitmap(setBackground(this.list.verticalScrollBar.visible ? this._width - 15 : this._width));
      this.dp.invalidate();
    }

    override public function set height(param1:Number) : void {
      this._height = int(param1);
      this.list.height = this._height - 20;
    }
  }
}
