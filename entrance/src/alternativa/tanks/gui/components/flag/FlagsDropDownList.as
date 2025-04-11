package alternativa.tanks.gui.components.flag {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.models.panel.create.ClanCreateService;
  import controls.dropdownlist.DropDownList;
  import fl.events.ListEvent;
  import flash.events.Event;
  import forms.Styles;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class FlagsDropDownList extends DropDownList {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var clanCreateService:ClanCreateService;

    private static const COUNTRY:String = "country";

    public var flag:Flag = new Flag();

    public function FlagsDropDownList() {
      super();
      var local1:int = 0;
      while(local1 < clanCreateService.flags.length) {
        addItem({
          "country":clanCreateService.flags[local1],
          "gameName":""
        });
        local1++;
      }
      this.selectItemByField(COUNTRY,clanCreateService.defaultFlag);
      width = 70;
      this.flag.mouseEnabled = false;
      addChild(this.flag);
      this.flag.x = 8;
      this.flag.y = 30 - this.flag.height >> 1;
      addEventListener(Event.CHANGE,this.onChange,false,0,true);
      height = (Math.min(clanCreateService.flags.length,6) + 1) * rowHeight + 14;
    }

    override public function setRenderer(param1:Class) : void {
      getList().setStyle(Styles.CELL_RENDERER,FlagsRenderer);
    }

    override public function selectItemByField(param1:String, param2:Object) : void {
      var local3:int = 0;
      local3 = findItemIndexByField(param1,param2);
      if(local3 != -1) {
        _selectedItem = dp.getItemAt(local3);
        _value = _selectedItem[COUNTRY];
        this.flag.setFlag(ClanFlag(_value));
        getList().selectedIndex = local3;
        getList().scrollToSelected();
      }
    }

    private function onChange(param1:Event) : void {
      this.selectItemByField(COUNTRY,selectedItem[COUNTRY]);
    }

    override protected function onItemClick(param1:ListEvent) : void {
      var local2:Object = param1.item;
      _selectedIndex = param1.index;
      _selectedItem = local2;
      close();
      dispatchEvent(new Event(Event.CHANGE));
    }
  }
}
