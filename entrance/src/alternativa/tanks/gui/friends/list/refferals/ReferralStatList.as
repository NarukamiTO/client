package alternativa.tanks.gui.friends.list.refferals {
  import controls.TankWindowInner;
  import controls.statassets.StatLineBase;
  import controls.statassets.StatLineNormal;
  import controls.statassets.StatLineNormalActive;
  import controls.statassets.StatLineSelected;
  import controls.statassets.StatLineSelectedActive;
  import fl.controls.List;
  import fl.data.DataProvider;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import forms.events.StatListEvent;
  import projects.tanks.client.panel.model.referrals.ReferralIncomeData;
  import utils.ScrollStyleUtils;

  public class ReferralStatList extends Sprite {
    private var inner:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
    private var header:ReferralStatHeader = new ReferralStatHeader();
    private var list:List = new List();
    private var dp:DataProvider = new DataProvider();
    private var currentSort:int = 1;

    public function ReferralStatList() {
      super();
      this.list.rowHeight = 20;
      this.list.setStyle("cellRenderer",ReferralStatListRenderer);
      this.list.dataProvider = this.dp;
      this.list.focusEnabled = true;
      ScrollStyleUtils.setGreenStyle(this.list);
      addChild(this.inner);
      this.inner.addChild(this.header);
      this.header.y = 4;
      this.header.x = 4;
      this.inner.addChild(this.list);
      this.list.y = this.header.y + this.header.height + 2;
      this.list.x = this.header.x;
      this.header.addEventListener(StatListEvent.UPDATE_SORT,this.changeSort);
    }

    private function clear() : void {
      var local1:Object = {};
      var local2:int = 0;
      while(local2 < this.dp.length) {
        local1 = this.dp.getItemAt(local2);
        local1.sort = this.currentSort;
        this.dp.replaceItemAt(local1,local2);
        local2++;
      }
      this.sort();
    }

    private function sort() : void {
      if(this.currentSort == 0) {
        this.dp.sortOn("uid",Array.CASEINSENSITIVE);
      } else {
        this.dp.sortOn("income",Array.NUMERIC | Array.DESCENDING);
      }
      var local1:Boolean = this.list.maxVerticalScrollPosition > 0;
      var local2:Number = local1 ? this.header.width + 25 : this.header.width;
      this.list.width = local1 ? this.header.width + 7 : this.header.width;
      ReferralStatLineBackgroundNormal.bg = new Bitmap(this.setBackground(local2,false));
      ReferalStatLineBackgroundSelected.bg = new Bitmap(this.setBackground(local2,true));
      this.dp.invalidate();
    }

    public function addReferrals(param1:Vector.<ReferralIncomeData>) : void {
      var local2:ReferralIncomeData = null;
      var local3:Object = null;
      for each(local2 in param1) {
        local3 = {};
        local3.userId = local2.user;
        local3.income = local2.income;
        local3.sort = this.currentSort;
        this.dp.addItem(local3);
      }
      this.header.setDefaultSort();
      this.currentSort = 1;
      this.sort();
    }

    private function setBackground(param1:int, param2:Boolean) : BitmapData {
      var local4:StatLineBase = null;
      var local3:Sprite = new Sprite();
      var local5:Array = [0,param1 - 120,param1 - 1];
      var local6:BitmapData = new BitmapData(param1,20,true,0);
      var local7:uint = 0;
      while(local7 < 2) {
        local4 = this.currentSort == local7 ? (param2 ? new StatLineSelectedActive() : new StatLineNormalActive()) : (param2 ? new StatLineSelected() : new StatLineNormal());
        local4.width = local5[local7 + 1] - local5[local7] - 2;
        local4.height = 18;
        local4.x = local5[local7];
        local3.addChild(local4);
        local7++;
      }
      local6.draw(local3);
      return local6;
    }

    private function changeSort(param1:StatListEvent) : void {
      this.currentSort = param1.sortField;
      this.clear();
    }

    public function resize(param1:Number, param2:Number) : void {
      this.inner.height = param2;
      this.list.height = this.inner.height - 32;
      this.inner.width = param1;
      this.header.width = param1 - 6;
      this.list.width = this.header.width;
    }

    public function hide() : void {
      this.dp.removeAll();
    }
  }
}
