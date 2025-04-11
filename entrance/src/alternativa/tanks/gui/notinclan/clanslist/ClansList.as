package alternativa.tanks.gui.notinclan.clanslist {
  import alternativa.tanks.models.service.ClanUserNotificationsManager;
  import alternativa.tanks.models.user.ClanUserService;
  import alternativa.types.Long;
  import fl.controls.List;
  import flash.display.Sprite;
  import flash.utils.Dictionary;
  import forms.Styles;
  import utils.ScrollStyleUtils;

  public class ClansList extends Sprite {
    [Inject]
    public static var clanUserService:ClanUserService;

    protected var dataProvider:ClansDataProvider;
    protected var list:List;
    protected var viewed:Dictionary;
    protected var _width:Number;
    protected var _height:Number;

    private var header:ClansListHeader;

    public function ClansList() {
      super();
      this.viewed = new Dictionary();
      this.header = new ClansListHeader();
      addChild(this.header);
      this.list = new List();
      this.list.y = 20;
      this.list.rowHeight = 20;
      this.list.setStyle(Styles.CELL_RENDERER,ClansListRenderer);
      this.list.focusEnabled = true;
      this.list.selectable = false;
      ScrollStyleUtils.setGreenStyle(this.list);
      this.dataProvider = new ClansDataProvider();
      this.dataProvider.getItemAtHandler = this.markAsViewed;
      this.dataProvider.sortOn(["isNew","name"],[Array.NUMERIC | Array.DESCENDING,Array.CASEINSENSITIVE]);
      this.list.dataProvider = this.dataProvider;
      addChild(this.list);
      ScrollStyleUtils.setGreenStyle(this.list);
    }

    private function markAsViewed(param1:Object) : void {
      if(!this.isViewed(param1)) {
        if(param1.type == ClanListType.INCOMING) {
          ClanUserNotificationsManager.removeIncomingNotification(param1.id);
        }
        this.setAsViewed(param1);
      }
    }

    public function removeAllViewed() : void {
      var local1:Object = null;
      for(local1 in this.viewed) {
        ClanUserNotificationsManager.removeIncomingNotification(local1.id);
      }
    }

    public function addClan(param1:Long, param2:String) : void {
      this.dataProvider.addClan(param1,param2);
      this.resize(this._width,this._height);
    }

    public function removeClan(param1:Long) : void {
      this.dataProvider.removeClan(param1);
      this.dataProvider.refresh();
      this.resize(this._width,this._height);
    }

    protected function isViewed(param1:Object) : Boolean {
      return param1 in this.viewed;
    }

    protected function setAsViewed(param1:Object) : void {
      this.viewed[param1] = true;
    }

    public function refresh() : void {
      this.dataProvider.refresh();
    }

    public function fillClansList(param1:Vector.<Long>, param2:String) : void {
      var local3:Long = null;
      this.dataProvider.removeAll();
      this.dataProvider.resetFilter(false);
      for each(local3 in param1) {
        this.dataProvider.addClan(local3,param2,false);
      }
      this.dataProvider.refresh();
      this.resize(this._width,this._height);
    }

    public function filterByProperty(param1:String, param2:String) : void {
      this.dataProvider.setFilter(param1,param2);
      this.resize(this._width,this._height);
    }

    public function resize(param1:Number, param2:Number) : void {
      this._width = param1;
      this._height = param2;
      this.header.width = param1;
      this.list.height = this._height - 20;
      var local3:Boolean = this.list.verticalScrollBar.visible;
      this.list.width = local3 ? this._width + 6 : this._width;
    }
  }
}
