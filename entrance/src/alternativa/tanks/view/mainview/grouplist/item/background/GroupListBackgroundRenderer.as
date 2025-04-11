package alternativa.tanks.view.mainview.grouplist.item.background {
  import alternativa.tanks.view.mainview.grouplist.header.GroupHeader;
  import controls.cellrenderer.ButtonState;
  import flash.display.Sprite;

  public class GroupListBackgroundRenderer extends Sprite {
    private static const GAP:int = 2;

    private var backgrounds:Vector.<ButtonState>;
    private var sumParts:int = 0;

    public function GroupListBackgroundRenderer(param1:Class) {
      var local3:ButtonState = null;
      this.backgrounds = new Vector.<ButtonState>();
      super();
      var local2:int = 0;
      while(local2 < GroupHeader.HEADER_INFOS.length) {
        local3 = ButtonState(new param1());
        this.backgrounds.push(local3);
        addChild(local3);
        this.sumParts += GroupHeader.HEADER_INFOS[local2].getPartOfHeader();
        local2++;
      }
      this.resize();
    }

    private function resize() : void {
      var local3:ButtonState = null;
      var local4:int = 0;
      var local1:int = 0;
      var local2:int = 0;
      while(local2 < GroupHeader.HEADER_INFOS.length) {
        local3 = this.backgrounds[local2];
        local3.x = local1;
        local4 = width * GroupHeader.HEADER_INFOS[local2].getPartOfHeader() / this.sumParts;
        local3.width = local4 - GAP;
        local1 += local4;
        local2++;
      }
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      this.resize();
    }
  }
}
