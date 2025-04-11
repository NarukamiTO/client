package alternativa.tanks.gui.components.rank {
  import controls.dropdownlist.DropDownList;
  import flash.events.Event;
  import forms.Styles;
  import forms.ranks.SmallRankIcon;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;

  public class RanksDropDownList extends DropDownList {
    [Inject]
    public static var rankService:RankService;

    private static const RANK:String = "rank";

    private var rankIcon:SmallRankIcon = new SmallRankIcon();

    public function RanksDropDownList(param1:int) {
      super();
      var local2:int = param1;
      while(local2 <= rankService.rankNames.length) {
        addItem({
          "gameName":"",
          "rank":local2,
          "rang":0
        });
        local2++;
      }
      this.rankIcon.x = 9;
      this.rankIcon.y = 8;
      this.rankIcon.mouseEnabled = false;
      addChild(this.rankIcon);
      width = 61;
      addEventListener(Event.CHANGE,this.onChange,false,0,true);
    }

    override public function selectItemByField(param1:String, param2:Object) : void {
      var local3:int = findItemIndexByField(param1,param2);
      if(local3 != -1) {
        _selectedItem = dp.getItemAt(local3);
        _value = _selectedItem[RANK];
        this.rankIcon.init(false,int(_value));
        getList().selectedIndex = local3;
        getList().scrollToSelected();
      }
    }

    private function onChange(param1:Event) : void {
      this.selectItemByField(RANK,selectedItem[RANK]);
    }

    override public function setRenderer(param1:Class) : void {
      getList().setStyle(Styles.CELL_RENDERER,RanksRenderer);
    }
  }
}
