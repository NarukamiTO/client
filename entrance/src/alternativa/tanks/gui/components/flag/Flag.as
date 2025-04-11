package alternativa.tanks.gui.components.flag {
  import alternativa.tanks.models.panel.create.ClanCreateService;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import projects.tanks.client.clans.clan.clanflag.ClanFlag;

  public class Flag extends Sprite {
    [Inject]
    public static var clanCreateService:ClanCreateService;

    public var country:ClanFlag;

    private var flag:Bitmap;

    public function Flag(param1:ClanFlag = null) {
      super();
      if(param1 == null) {
        param1 = clanCreateService.defaultFlag;
      }
      this.setFlag(param1);
    }

    public static function getFlag(param1:ClanFlag) : Bitmap {
      return new Bitmap(param1.flagImage.data);
    }

    public function setFlag(param1:ClanFlag) : void {
      this.removeAllChildren();
      this.flag = getFlag(param1);
      this.country = param1;
      addChild(this.flag);
    }

    private function removeAllChildren() : void {
      while(numChildren > 0) {
        removeChildAt(0);
      }
    }
  }
}
