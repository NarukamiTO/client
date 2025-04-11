package fl.controls.listClasses {
  import fl.core.UIComponent;

  public class TileListData extends ListData {
    protected var _source:Object;

    public function TileListData(param1:String, param2:Object, param3:Object, param4:UIComponent, param5:uint, param6:uint, param7:uint = 0) {
      super(param1,param2,param4,param5,param6,param7);
      _source = param3;
    }

    public function get source() : Object {
      return _source;
    }
  }
}
