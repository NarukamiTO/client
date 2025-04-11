package alternativa.tanks.battle.scene3d {
  import alternativa.engine3d.objects.Decal;
  import alternativa.tanks.battle.BattleService;
  import flash.utils.getTimer;

  public class FadingDecalsRenderer implements Renderer {
    [Inject]
    public static var battleService:BattleService;

    private var fadeTime:int;
    private var entries:Vector.<DecalEntry> = new Vector.<DecalEntry>();
    private var numDecals:int;

    public function FadingDecalsRenderer(param1:int) {
      super();
      this.fadeTime = param1;
    }

    public function render(param1:int, param2:int) : void {
      var local7:DecalEntry = null;
      var local8:int = 0;
      var local3:int = 0;
      var local4:int = this.numDecals;
      var local5:int = 0;
      while(local5 < local4) {
        local7 = this.entries[local5];
        local8 = param1 - local7.startTime;
        if(local8 > this.fadeTime) {
          local3++;
          battleService.getBattleScene3D().removeDecal(local7.decal);
          --this.numDecals;
        } else {
          local7.decal.alpha = 1 - local8 / this.fadeTime;
          if(local3 > 0) {
            this.entries[local5 - local3] = local7;
          }
        }
        local5++;
      }
      var local6:int = this.numDecals;
      while(local6 < local4) {
        this.entries[local6] = null;
        local6++;
      }
    }

    public function add(param1:Decal) : void {
      var local2:* = this.numDecals++;
      this.entries[local2] = new DecalEntry(param1,getTimer());
    }
  }
}
