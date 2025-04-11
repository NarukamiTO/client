package alternativa.tanks.gui.notinclan.clanslist {
  import alternativa.tanks.models.clan.info.IClanInfoModel;
  import alternativa.tanks.models.service.ClanUserNotificationsManager;
  import alternativa.tanks.models.user.ClanUserService;
  import alternativa.types.Long;
  import fl.data.DataProvider;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;

  public class ClansDataProvider extends DataProvider {
    [Inject]
    public static var clanUserService:ClanUserService;

    private static var _escapePattern:RegExp = /\-|\./;
    private static var _globSearchPattern:RegExp = /\*/g;

    private var _getItemAtHandler:Function;
    private var _store:Dictionary = new Dictionary();
    private var _filterString:String = "";
    private var _sortFields:Object = ["id"];
    private var _sortFieldsProperties:Object = null;
    private var _filterPropertyName:String;
    private var _filterPattern:RegExp;

    public function ClansDataProvider() {
      super();
    }

    private static function prepareSearchPattern(param1:String) : RegExp {
      param1 = param1.replace(_escapePattern,"\\$&").replace(_globSearchPattern,".*");
      param1 = "^" + param1;
      return new RegExp(param1,"i");
    }

    public function addClan(param1:Long, param2:String, param3:Boolean = true) : Object {
      var local4:Object = {};
      local4.id = param1;
      local4.type = param2;
      local4.name = this.getClanName(param1);
      local4.isNew = ClanUserNotificationsManager.clanInIncomingNotifications(param1);
      this._store[param1] = local4;
      super.addItem(this._store[param1]);
      if(param3) {
        this.refresh();
      }
      return this._store[param1];
    }

    private function getClanName(param1:Long) : String {
      var local2:IGameObject = clanUserService.getObjectById(param1);
      var local3:IClanInfoModel = local2.adapt(IClanInfoModel) as IClanInfoModel;
      return local3.getClanName();
    }

    public function get getItemAtHandler() : Function {
      return this._getItemAtHandler;
    }

    public function set getItemAtHandler(param1:Function) : void {
      this._getItemAtHandler = param1;
    }

    override public function getItemAt(param1:uint) : Object {
      var local2:Object = super.getItemAt(param1);
      if(this.getItemAtHandler != null) {
        this.getItemAtHandler(local2);
      }
      return local2;
    }

    public function removeClan(param1:Long) : void {
      if(param1 in this._store) {
        super.removeItem(this._store[param1]);
        delete this._store[param1];
      }
    }

    public function resetFilter(param1:Boolean = true) : void {
      var local2:Object = null;
      this._filterString = "";
      if(!param1) {
        return;
      }
      super.removeAll();
      for each(local2 in this._store) {
        super.addItem(local2);
      }
      this.reSort();
    }

    override public function sortOn(param1:Object, param2:Object = null) : * {
      this._sortFields = param1;
      this._sortFieldsProperties = param2;
      super.sortOn(this._sortFields,this._sortFieldsProperties);
    }

    public function reSort() : void {
      super.sortOn(this._sortFields,this._sortFieldsProperties);
    }

    public function filter() : void {
      var local1:Object = null;
      if(this._filterString != "") {
        super.removeAll();
        for each(local1 in this._store) {
          if(this.isFilteredItem(local1)) {
            super.addItem(local1);
          }
        }
      }
      this.reSort();
    }

    public function setFilter(param1:String, param2:String) : void {
      if(param2 == "" && this._filterString != "") {
        this.resetFilter();
        return;
      }
      this._filterPropertyName = param1;
      this._filterString = param2;
      this._filterPattern = prepareSearchPattern(this._filterString);
      this.filter();
    }

    private function isFilteredItem(param1:Object) : Boolean {
      return Boolean(param1.hasOwnProperty(this._filterPropertyName)) && param1[this._filterPropertyName].search(this._filterPattern) != -1;
    }

    public function refresh() : void {
      this.filter();
    }
  }
}
